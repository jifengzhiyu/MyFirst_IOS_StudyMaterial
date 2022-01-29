//
//  WBRefreshControl.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/7.
//

import UIKit
//自定义刷新空间--刷新逻辑

/// 下拉刷新控件偏移量
private let WBRefreshControlOffset: CGFloat = -60

class WBRefreshControl: UIRefreshControl {
    
    // MARK: - 重写系统方法
    override func endRefreshing() {
        super.endRefreshing()
        
        // 停止动画
        refreshView.stopAnimation()
    }
    
    /// 主动触发开始刷新动画 － 不会触发监听方法
    override func beginRefreshing() {
        super.beginRefreshing()
        
        refreshView.startAnimation()
    }

    // MARK: - KVO 监听方法（监听属性变化）
    /**
        1. 始终待在屏幕上
        2. 下拉的时候，frame 的 y 一直变小，相反（向上推）一直变大
        3. 默认的 y 是 0
    */
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if frame.origin.y > 0{
            return
        }
        // 判断是否正在刷新
        if isRefreshing {
            refreshView.startAnimation()
            return
        }
        
        if frame.origin.y < WBRefreshControlOffset && !refreshView.rotateFlag {
            print("反过来")
            refreshView.rotateFlag = true
//            refreshView.startAnimation()

        } else if frame.origin.y >= WBRefreshControlOffset && refreshView.rotateFlag {
            print("转过去")
            refreshView.rotateFlag = false

        }
        
//        print(self.frame)

    }
    
    // MARK: - 构造函数
    override init() {
        super.init()
        
        setupUI()
    }
    //构造函数和required init?(coder aDecoder: NSCoder)都写setUpUI保证 无论xib还是sb都会激活setUp（自定义控件)
    //https://blog.csdn.net/u014599371/article/details/79892770
    //当我们使用storyboard实现界面的时候，程序会调用这个初始化器。
//    注意要去掉fatalError，fatalError的意思是无条件停止执行并打印。
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    // MARK: - 设置界面
    /// 设置界面
    private func setupUI() {
        // 隐藏转轮
        tintColor = UIColor.clear
        
        addSubview(refreshView)
        
        // 2. 自动布局
        refreshView.snp.makeConstraints { (make) -> Void in
//xib自动布局一定要加上 大小约束
            make.center.equalTo(self.snp.center)
            make.size.equalTo(refreshView.bounds.size)
        }
        // 3. KVO 监听,一定要搭配 deinit
        //加上 DispatchQueue.main.async，就会在网络加载之后执行
        // 使用 KVO 监听位置变化 - 主队列，当主线程有任务，就不调度队列中的任务执行
        // 让当前运行循环中所有代码执行完毕后，运行循环结束前，开始监听
        // 方法触发会在下一次运行循环开始！
        DispatchQueue.main.async() {
            self.addObserver(self, forKeyPath: "frame", options: [], context: nil)
    }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "frame")
    }
    
    // MARK: - 懒加载控件
    private lazy var refreshView: WBRefreshView = WBRefreshView.refreshView()

}

/// 微博刷新视图 - 负责刷新动画显示
class WBRefreshView: UIView {
    
    /// 旋转标记
    var rotateFlag = false {
        didSet {
            rotateTipIcon()
        }
    }
   
    @IBOutlet weak var tipIconView: UIImageView!
    
    @IBOutlet weak var tipView: UIView!
    /// 旋转图标动画
    @IBOutlet weak var loadIconView: UIImageView!
    
    func rotateTipIcon() {
        
         var angle = CGFloat(Double.pi)
        angle += rotateFlag ? -0.0000001 : 0.0000001
        
        // 旋转动画，特点：顺时针优先 + `就近原则`
        UIView.animate(withDuration: 0.5) { () -> Void in
            
             self.tipIconView.transform = self.tipIconView.transform.rotated(by: CGFloat(angle))

        }
    }
    
    /// 播放加载动画
     func startAnimation() {
        
        tipView.isHidden = true
        
//        // 判断动画是否已经被添加
         //为了避免多次调用
        let key = "transform.rotation"
         if loadIconView.layer.animation(forKey: key) != nil {
            return
        }

        print("加载动画播放")
        
        let anim = CABasicAnimation(keyPath: key)

        
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 0.5
        anim.isRemovedOnCompletion = false
        
         loadIconView.layer.add(anim, forKey: key)

    }
    
    /// 停止加载动画
     func stopAnimation() {
        tipView.isHidden = false
        layer.removeAllAnimations()
    }
    
    /// 加载 XIB,一定要写类函数
    class func refreshView() -> WBRefreshView {
        
        let nib = UINib(nibName: "WBRefreshView", bundle: nil)
        
        return nib.instantiate(withOwner: nil, options: nil).last as! WBRefreshView
    }
    
}
