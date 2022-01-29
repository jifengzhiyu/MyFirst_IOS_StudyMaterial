//
//  ComposeViewController.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/13.
//

import UIKit
import SVProgressHUD
// MARK: - 撰写控制器
class ComposeViewController: UIViewController {
    
    /// 照片选择控制器
    private lazy var picturePickerController = PicturePickerController()
    
    /// 表情键盘视图
    private lazy var emoticonView: EmoticonView = EmoticonView { [weak self] (emoticon) -> () in
        
        self?.textView.insertEmoticon(em: emoticon)
    }
    
    // MARK: - 监听方法
    /// 关闭
    @objc private func close() {
        // 关闭键盘
        textView.resignFirstResponder()
        
        dismiss(animated: true, completion: nil)
    }

    /// 发布微博
    @objc private func sendStatus() {
//        print("发布微博")
        // 1. 获取文本内容
        let text = textView.emoticonText
        
        // 2. 发布微博
//        let image = UIImage(named: "123")
        let image = picturePickerController.pictures.last

        NetworkTools.sharedTools.sendStatus(status: text, image: image) { (result, error) -> () in
            
            if error != nil {
                print("出错了")
                SVProgressHUD.showInfo(withStatus: "您的网络不给力")
                return
            }

            print(result as Any)
            // 关闭控制器
            self.close()
        }
    }
    
    /// 选择照片
    @objc private func selectPicture() {
        print("选择照片 \(picturePickerController.view.frame)")
        
        // 退掉键盘
        textView.resignFirstResponder()
        
        // 0. 判断如果已经更新了约束，不再执行后续代码
        if picturePickerController.view.frame.height > 0 {
            return
        }
        
        // 1. 修改照片选择控制器视图的约束
        picturePickerController.view.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(view.bounds.height * 0.6)
        }
        // 2. 修改文本视图的约束 - 重建约束 - 会将之前`textView`的所有的约束删除
        //更改参照视图需要这样
        textView.snp.remakeConstraints { make in
//            make.top.equalTo(self.snp.topLayoutGuideBottom)
            make.top.equalTo(view.snp.top)

            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(picturePickerController.view.snp.top)
        }
        
        
        // 3. 动画更新约束
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    /// 选择表情
    @objc private func selectEmoticon() {
        // 如果使用的是系统键盘 nil
        print("选择表情 \(textView.inputView)")
        // 1. 退掉键盘
        textView.resignFirstResponder()
        
        // 2. 设置键盘
        textView.inputView = textView.inputView == nil ? emoticonView : nil
        
        // 3. 重新激活键盘
        textView.becomeFirstResponder()
 
    }
    
    // MARK: - 键盘处理
    /// 键盘变化处理
    @objc private func keyboardChanged(n: NSNotification) {
//        print(n)
        // 1. 获取目标的 rect - 字典中的`结构体`是 NSValue
        let rect = (n.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        print(rect)
        // 获取目标的动画时长 - 字典中的数值是 NSNumber
        let duration = (n.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        // 动画曲线数值
        let curve = (n.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue
        
        let offset = -UIScreen.main.bounds.height + rect.origin.y
        
        // 2. 更新约束
        toolbar.snp.updateConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp.bottom).offset(offset)
        }
        
        // 3. 动画 － UIView 块动画 本质上是对 CAAnimation 的包装
        UIView.animate(withDuration: duration) { () -> Void in
            // 设置动画曲线
            /**
                曲线值 = 7
                － 如果之前的动画没有完成，有启动了其他的动画，让动画的图层直接运动到后续动画的目标位置
                － 一旦设置了 `7`，动画时长无效，动画时长统一变成 0.5s
            */
            UIView.setAnimationCurve(UIView.AnimationCurve(rawValue: curve)!)
            //更新约束，产生动画
            self.view.layoutIfNeeded()
        }
        
        // 调试动画时长 － keyPath 将动画添加到图层
        let anim = toolbar.layer.animation(forKey: "position")
        print("动画时长 \(anim?.duration ?? 0)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加键盘通知
        NotificationCenter.default.addObserver(self,
            selector: #selector(self.keyboardChanged(n:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
        
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 视图生命周期
    override func loadView() {
        view = UIView()

        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 激活键盘 - 如果已经存在照片控制器视图，不再激活键盘
        if picturePickerController.view.frame.height == 0 {
            textView.becomeFirstResponder()    }
    }
        
    // MARK: - 懒加载控件
    /// 工具条
    private lazy var toolbar = UIToolbar()
    
    /// 文本视图
    private lazy var textView: UITextView = {
        let tv = UITextView()
        
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.textColor = UIColor.darkGray
        
        // 始终允许垂直滚动
        tv.alwaysBounceVertical = true
        // 拖拽关闭键盘
        tv.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        
        // 设置文本视图的代理
//        tv.delegate = self
        
        return tv
    }()
    
    /// 占位标签
    private lazy var placeHolderLabel: UILabel = UILabel(title: "分享新鲜事...",
        fontSize: 18,
        color: UIColor.lightGray)
    
}

// MARK: - UITextViewDelegate
extension ComposeViewController :UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
        placeHolderLabel.isHidden = textView.hasText
    }
}


// MARK: - 设置界面
private extension ComposeViewController {
    
    func setupUI() {
        // 0. 取消自动调整滚动视图间距
        //    @available(iOS, introduced: 7.0, deprecated: 11.0, message: "Use UIScrollView's contentInsetAdjustmentBehavior instead")
//        automaticallyAdjustsScrollViewInsets = false
        
        // 1. 设置背景颜色
        view.backgroundColor = UIColor.white
        
        // 2. 设置控件
        prepareNavigationBar()
        prepareToolbar()
        prepareTextView()
        preparePicturePicker()

        // 输入助理视图 - 当推掉键盘之后，toolbar 会消失！
        //textView.inputAccessoryView = toolbar

    }
    
    /// 准备照片选择控制器
    private func preparePicturePicker() {
        
        // 0. 添加子控制器
        addChild(picturePickerController)
        
        // 1. 添加视图
        view.insertSubview(picturePickerController.view, belowSubview: toolbar)
//        view.addSubview(picturePickerController.view)

        
        // 2. 自动布局
        picturePickerController.view.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(0)
//            make.height.equalTo(view.snp.height).multipliedBy(0.6)

        }
    }
    
    /// 准备文本视图
    private func prepareTextView() {
        view.addSubview(textView)
        
        textView.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(toolbar.snp.top)
        }
        textView.text = "分享新鲜事"
        // 添加占位标签
        textView.addSubview(placeHolderLabel)

        placeHolderLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(textView.snp.top).offset(8)
            make.left.equalTo(textView.snp.left).offset(5)
        }
    }
    
    
    /// 准备工具条
    private func prepareToolbar() {
        // 1. 添加控件
        view.addSubview(toolbar)
        // 设置背景颜色
        toolbar.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
//
        // 2. 自动布局
        toolbar.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(44)
        }
        
        // 3. 添加按钮
        let itemSettings = [["imageName": "compose_toolbar_picture", "actionName": "selectPicture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background", "actionName": "selectEmoticon"],
            ["imageName": "compose_addbutton_background"]]
        
        var items = [UIBarButtonItem]()
        
        for dict in itemSettings {
            items.append(UIBarButtonItem(imageName: dict["imageName"]!,
                target: self,
                actionName: dict["actionName"]))
            
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        
        // 一旦复制，相当于做了一次copy
        toolbar.items = items
    }
    
    /// 设置导航栏
    private func prepareNavigationBar() {
        
        // 1. 左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(self.close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain,target: self, action:  #selector(self.sendStatus))
        
        // 禁用发布微博按钮
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // 2. 标题视图
        //局部变量
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
//        titleView.backgroundColor = .blue
        //强引用
        navigationItem.titleView = titleView
        
        // 3. 添加子控件
        let titleLabel = UILabel(title: "发微博", fontSize: 15)
        let nameLabel = UILabel(title: UserAccountViewModel.sharedUserAccount.account?.screen_name ?? "想吃酸菜鱼",
            fontSize: 13,
            color: UIColor.lightGray)
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(nameLabel)
        
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleView.snp.centerX)
            make.top.equalTo(titleView.snp.top)
        }
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleView.snp.centerX)
            make.bottom.equalTo(titleView.snp.bottom)
        }
    }
    
    
}
