//
//  DetailViewController.swift
//  通讯录
//
//  Created by 翟佳阳 on 2021/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    var person: Person?
    /// 定义闭包属性
    var didSaveCallBack: (()->())?
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var ageText: UITextField!
    
    //保存
    @IBAction func save(_ sender: Any) {
        // 1. 使用 UI 更新模型
        person?.name = nameText.text
        // 第一个 ! 保证字符串一定有内容
        // 第二个 ! 保证一定能转换成整数
        //第二个!不能保证改为 ?? 0
        person?.age = Int(ageText.text!) ?? 0
        
        print(person!)
        // 2. 完成回调，通知控制器刷新数据 － 闭包！
        // ? 表示如果闭包不存在，就不执行 -> OC 中调用block之前一定要判断！
        // 如果强行解包，同时没有设置数值，会崩溃
        didSaveCallBack?()
        
        // 关闭控制器
        //pop返回上一个页面
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func textChanged() {
        // 如果两个输入框都有内容，才允许保存
               navigationItem.rightBarButtonItem?.isEnabled = nameText.hasText && ageText.hasText
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameText.text = person?.name
        ageText.text = "\(person?.age ?? 0)"
        
        //激活按钮
        textChanged()
        
        // Do any additional setup after loading the view.
    }
    

    
    
   
}
