//
//  VisitorView.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/24.
//

import UIKit
import SnapKit
///// 访客视图的协议
//protocol VisitorViewDelegate: NSObjectProtocol{
//    /// 注册
//    func visitorViewDidRegister()
//    /// 登录
//    func visitorViewDidLogin()
//}


/// 访客视图 － 处理用户未登录的界面显示
class VisitorView: UIView {
    /// 代理
    //？ weak释放指向nil
//    weak var delegate: VisitorViewDelegate?
    
    
//    // MARK: - 监听方法
//    @objc private func clickLogin(){
//        delegate?.visitorViewDidLogin()
//    }
//
//    @objc private func clickRegister(){
//        delegate?.visitorViewDidRegister()
//    }
    
    
    

    // MARK: - 设置视图信息
    /// 设置视图信息
    ///
    /// - parameter imageName: 图片名称，首页设置为 nil
    /// - parameter title:     消息文字
    func setUpInfo(imageName: String?, title: String){
        messageLabel.text = title
        
        // 如果图片名称为 nil，说明是首页，直接返回
        guard let imgeName = imageName else {
            startAnim()
            return
        }
        
        iconView.image = UIImage(named: imgeName)
        // 隐藏小房子
        homeIconView.isHidden = true
        // 将遮罩图像移动到底层
sendSubviewToBack(maskIconView)
    }
    
    /// 开启首页转轮动画
    private func startAnim(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        anim.toValue = 2.0 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 5
        
        //用在不断重复的动画上，当动画绑定的图层对应的视图被销毁，动画会自动被销毁
        anim.isRemovedOnCompletion = false
        
        // 添加到图层
        iconView.layer.add(anim, forKey: nil)
    }
    
    
    
    // MARK: - 构造函数
    // initWithFrame 是 UIView 的指定构造函数
    // 使用纯代码开发使用的
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    // initWithCoder - 使用 SB & XIB 开发加载的函数
    // 使用 sb 开始的入口
    required init?(coder: NSCoder) {
        // 导致如果使用 SB 开发，调用这个视图，会直接崩溃
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        
        setUpUI()
    }
    
    
    // MARK: - 懒加载控件
    /// 图标，使用 image: 构造函数创建的 imageView 默认就是 image 的大小
      private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    /// 遮罩图像
    private lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    /// 小房子
    private lazy var homeIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    /// 消息文字
    private lazy var messageLabel:UILabel = UILabel(title: "关注一些人，回这里看看有什么惊喜关注一些人，回这里看看有什么惊喜")
    
    /// 注册按钮
     lazy var registerButton:UIButton = UIButton(title: "注册", color: .orange, backImageName: "common_button_white_disable")
   
    
    /// 登录 按钮
     lazy var loginButton:UIButton = UIButton(title: "登录", color: .darkGray, backImageName: "common_button_white_disable")
    
}



//MARK: - extention设置VisitorView
extension VisitorView{
    //设置界面
    private func setUpUI(){
        
        backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
        
        //注意添加顺序
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeIconView)
        addSubview(messageLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 2. 设置自动布局
        /**
            - 添加约束需要添加到父视图上
            - 建议，子视图最好有一个统一的参照物！
        */
        // translatesAutoresizingMaskIntoConstraints 默认是 true，支持使用 setFrame 的方式设置控件位置
        // false 支持使用自动布局来设置控件位置
//        for v in subviews{
//            v.translatesAutoresizingMaskIntoConstraints = false
//        }
        //用了框架就不需要上面的代码
        // 1> 图标
//        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
//        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        iconView.snp.makeConstraints { make in
            // 指定 centerX 属性 等于 `参照对象`.`snp.`参照属性值
            // offset 就是指定相对视图约束的偏移量
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-60)
        }
        
//        // 2> 小房子
//        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
//        addConstraint(NSLayoutConstraint(item: homeIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        homeIconView.snp.makeConstraints { make in
            make.center.equalTo(iconView.snp.center)
        }
//
//
//        // 3> 消息文字
//        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
//        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 20))
//
//        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 224))
//        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(iconView.snp.centerX)
            make.top.equalTo(iconView.snp.bottom).offset(16)
            make.width.equalTo(224)
            make.height.equalTo(36)
        }
//
//        // 4> 注册按钮
//        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: messageLabel, attribute: .left, multiplier: 1.0, constant: 0))
//        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem:messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
//
//        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
//        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        registerButton.snp.makeConstraints { make in
            make.left.equalTo(messageLabel.snp.left)
            make.top.equalTo(messageLabel.snp.bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
//
//        // 5> 登录按钮
//        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: messageLabel, attribute: .right, multiplier: 1.0, constant: 0))
//        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem:messageLabel, attribute: .bottom, multiplier: 1.0, constant: 16))
//
//        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
//        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        loginButton.snp.makeConstraints { make in
            make.right.equalTo(messageLabel.snp.right)
            make.top.equalTo(registerButton.snp.top)
            make.width.equalTo(registerButton.snp.width)
            make.height.equalTo(registerButton.snp.height)
        }
//
//        // 6. 遮罩图像
//        /**
//            VFL : 可视化格式语言
//
//            H 水平方向
//            V 垂直方向
//            | 边界
//            [] 包装控件
//            views: 是一个字典 [名字: 控件名] - VFL 字符串中表示控件的字符串
//            metrics: 是一个字典 [名字: NSNumber] - VFL 字符串中表示某一个数值
//        */
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[mask]-0-|", options: [], metrics: nil, views: ["mask": maskIconView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mask]-(btnHeight)-[regButton]", options: [], metrics: ["btnHeight": -36], views: ["mask": maskIconView, "regButton": registerButton]))
//
//        // 设置背景颜色 - 灰度图 R = G = B，在 UI 元素中，大多数都使用灰度图，或者纯色图(安全色)
        
        
//        // 3. 添加监听方法
//        registerButton.addTarget(self, action: #selector(self.clickRegister), for: UIControl.Event.touchUpInside)
//        loginButton.addTarget(self, action: #selector(self.clickLogin), for: UIControl.Event.touchUpInside)
        maskIconView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(registerButton.snp.bottom)
        }
    }
    
}
