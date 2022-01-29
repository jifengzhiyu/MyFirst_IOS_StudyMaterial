//
//  ViewController.swift
//  表情字符串
//
//  Created by 翟佳阳 on 2021/12/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    // 目标 － 将字符串转换成带表情图片的属性字符串
    /**
        步骤
        1. 将 [爱你] 转换成表情模型
        2. 使用正则表达式过滤字符串[倒着遍历]
        3. 生成结果
    
        我[爱你]啊[笑哈哈]！
    
        正着遍历 - 一点替换了前面的内容，后面的 range 响应都会发生变化
            我[爱你的图片]啊[笑哈哈]！
    
        倒着遍历 - 第一次匹配的所有 range 都有效
            我[爱你的图片]啊[笑哈哈的图片]！
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let str = "我[爱你]啊[笑哈哈]！"
//        print(demo(string: "[爱你]"))
//        print(emoticonWi thString(string: "[爱你]"))
        label.attributedText = EmoticonManager.sharedManager.emoticonText(string: str, font: label.font)
    }

    
    /// 根据表情字符串，在表情包中查找对应的表情
    ///
    /// - parameter string: 表情字符串
    ///
    /// - returns: 表情模型
    private func emoticonWithString(string: String) -> Emoticon? {
     
        // 1. 遍历表情包数组
        for package in EmoticonManager.sharedManager.packages {
            
            // 过滤 emoticons 数组，查找 满足 em.chs == string 的表情模型
            // 1> 如果闭包有返回值，闭包代码只有一句，可以省略 return
            // 2> 如果有参数，参数可以使用 $0 $1...替代
            // 3> $0 对应的就是数组中的元素
            if let emoticon = package.emoticons.filter({ $0.chs == string }).last {
                
                return emoticon
            }
        }
        
        return nil
    }
    
    // 闭包基本代码
    private func demo(string: String) -> Emoticon? {
        
        // 1. 遍历表情包数组
        for package in EmoticonManager.sharedManager.packages {
            
            // 过滤 emoticons 数组，查找 em.chs == string 的表情模型
            let emoticon = package.emoticons.filter({ (em) -> Bool in
                return em.chs == string
            }).last
            
            if emoticon != nil {
                return emoticon
            }
        }
        
        return nil
    }
    
}

