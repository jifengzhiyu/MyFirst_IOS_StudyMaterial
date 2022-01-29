//
//  NewFeatureViewController.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/30.
//

import UIKit
import SnapKit
/// 可重用 CellId
private let WBNewFeatureViewCellId = "WBNewFeatureViewCellId"

/// 新特性图像的数量
private let WBNewFeatureImageCount = 4

class NewFeatureViewController: UICollectionViewController {
    // 懒加载属性，必须要在控制器实例化之后才会被创建
    // private lazy var layout = UICollectionViewFlowLayout()
    
    // MARK: - 构造函数
    init(){
        //        // super.指定的构造函数
    let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = UIScreen.main.bounds.size
        
//        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 构造函数，完成之后内部属性才会被创建
        super.init(collectionViewLayout: layout)
        
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // iOS 7.0 开始，就推荐要隐藏状态栏，可以每个控制器分别设置，默认是 NO
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        // 注册可重用Cell

        self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: WBNewFeatureViewCellId)

        // Do any additional setup after loading the view.
    }

   

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // 每个分组中，格子的数量
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return WBNewFeatureImageCount
    }
//Cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell :NewFeatureCell = collectionView.dequeueReusableCell(withReuseIdentifier: WBNewFeatureViewCellId, for: indexPath) as! NewFeatureCell
    
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.brown : UIColor.yellow
        // Configure the cell
        cell.imageIndex = indexPath.item
        
        return cell
    }
    
    // ScrollView 停止滚动方法
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 再最后一页才调用动画方法
        // 根据 contentOffset 计算页数
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        // 判断是否是最后一页
        if page != WBNewFeatureImageCount - 1 {
            return
        }
        
        // Cell 播放动画
        let cell = collectionView?.cellForItem(at: IndexPath(item: page, section: 0)) as! NewFeatureCell
        
        // 显示动画
        cell.showButtonAnim()
    }
}


// MARK: - 新特性 Cell
private class NewFeatureCell: UICollectionViewCell {
    /// 图像属性
     var imageIndex: Int = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
//            showButtonAnim()
            // 隐藏按钮
            startButton.isHidden = true
        }
    }
    
    /// 点击开始体验按钮
    @objc private func clickStartButton() {
        print("开始体验")
        
        //发送通知
        NotificationCenter.default.post(name:NSNotification.Name.init(rawValue: WBSwitchRootViewControllerNotification) , object: nil)
    }
    
    /// 显示按钮动画
     func showButtonAnim() {
        startButton.isHidden = false
        startButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        startButton.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 1.6,     // 动画时长
            delay: 0,                       // 延时时间
            usingSpringWithDamping: 0.6,    // 弹力系数，0~1，越小越弹
            initialSpringVelocity: 10,      // 初始速度，模拟重力加速度
            options: [],                    // 动画选项
            animations: { () -> Void in
                
            self.startButton.transform = .identity
                
            }) { (_) -> Void in
                self.startButton.isUserInteractionEnabled = true
                print("OK")
        }
        
    }
    
    // frame 的大小是 layout.itemSize 指定的
    override init(frame: CGRect) {
        super.init(frame: frame)
//        print(frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        // 1. 添加控件
        addSubview(iconView)
        addSubview(startButton )
        // 不能单纯在此设置隐藏 setUpUI在init NewFeatureCell里面，只会执行两次（可重用
        //在cell的数据源方法中，可以使用
        //        startButton.hidden = true
        
        // 2. 指定位置
        //bounds x,y 00
        //frame 0,0
        //bounds相对父控件 这里是cell
        //默认size 就是itemSize大小

//        print("frame:\(frame)")
//        print("bounds:\(bounds)")

        iconView.frame = bounds
        
//        iconView.backgroundColor = .blue
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).multipliedBy(0.7)
        }
        
        //3、监听方法
        startButton.addTarget(self, action: #selector(self.clickStartButton), for: .touchUpInside)
    }
    
    // MARK: - 懒加载控件
    /// 图像
    private lazy var iconView : UIImageView = UIImageView()
    /// 开始体验按钮
    private lazy var startButton: UIButton = UIButton(title: "开始体验", color: .white, backImageName: "new_feature_finish_button")
    
    
}
