//
//  ViewController.swift
//  表情键盘
//
//  Created by 翟佳阳 on 2021/12/9.
//
/**
    代码复核 － 对重构完成的代码进行检查

    1. 修改注释
    2. 确认是否需要进一步重构
    3. 再一次检查返回值和参数
*/
import UIKit

class ViewController: UIViewController {
    @IBAction func emoticonText(_ sender: Any) {
        
 print(textView.emoticonText)
        
    }
    
     @IBOutlet weak var textView: UITextView!

    
    
    deinit {
        print("888")
    }
    
    /// 表情键盘视图
    private lazy var emoticonView: EmoticonView = EmoticonView { [weak self] (emoticon) -> () in
        //闭包里面出现self小心循环引用
        self?.textView.insertEmoticon(em: emoticon)
//        self?.textView.text = emoticon.chs
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        textView.inputView = emoticonView
        textView.becomeFirstResponder()

        print(EmoticonManager.sharedManager)
        //单例只初始化一次，之后就用存在的，不会重复 加载
        print(EmoticonManager.sharedManager)

        
    }

    //测试
    func demo() {
        // 输入视图
        //        textView.inputView = UIButton(type: .ContactAdd)
        //width无法控制，默认屏幕的宽度
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 258))
        v.backgroundColor = UIColor.red
        
        // textView 会对 v 强引用
        textView.inputView = v
        
        // 输入辅助视图
        textView.inputAccessoryView = UIButton(type: .contactAdd)

    }
    
}

