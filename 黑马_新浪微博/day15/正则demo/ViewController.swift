//
//  ViewController.swift
//  正则demo
//
//  Created by 翟佳阳 on 2021/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 被匹配的字符串
        let str = "AAAA<a href=\"http://weibo.com/\">微博 weibo.com</a>BBBB"
         
        print(str.href()?.link ?? "")
        print(str.href()?.text ?? "")
        
//        print(str.href()?.link)
//        print(str.href()?.text)
        
//        demo()

       
}
    func demo() {
        /**
        是一个独立的语言，适用于所有的开发语言，甚至编辑器
        
        1. 匹配方案
        
        .   匹配任意字符，换行除外
        *   匹配任意多的字符
        ?   尽量少的匹配
        
        2. 常用函数
        firstMatchInString 在 指定的字符串中，查找`第一个`和 pattern 符合字符串
        matchesInString    在 指定的字符串中，查找所有和 pattern 符合的字符串
        
        3. 常用方法
        rangeAtIndex(index)
        
        index = 0 =>    取到所有和 pattern 匹配一致的字符串
        index = 1 =>    取到 pattern 中 (第一个) 内部的内容，依次递增
        
        4. pattern 的编写方法
        1> 将完整的字符串直接复制到 pattern
        2> 将需要获取的内容使用 `(.*?)` 设置
        3> 将不关心的内容，可变的内容使用 `.*?` 过滤并且忽略，能够适应更过的数据匹配
        
        5. 由于正则表达式适用于所有的语言，常用的正则表达式，可以直接`百度`
        */
        // 被匹配的字符串
        let str = "AAAA<a href=\"http://weibo.com/\">微博 weibo.com</a>BBBB"
        
        
        
        // 1. 创建正则表达式
        // 匹配方案 - 专门用来过滤字符串的
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        
        // throws 针对 pattern 是否正确的异常处理
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        // firstMatchInString 在 指定的字符串中，查找第一个和 pattern 符合字符串
        guard let result = regex.firstMatch(in: str, options: [], range: NSRange(location: 0, length: str.count)) else {
            print("没有匹配项目")
            return
        }
        
        print("查找范围的个数 \(result.numberOfRanges)")
        
        // 获取第0个范围
        let r = result.range(at: 0)
        // 根据返回获取子字符串
        let s = (str as NSString).substring(with: r)
        
        let r1 = result.range(at: 1)
        let link = (str as NSString).substring(with: r1)
        
        let r2 = result.range(at: 2)
        let text = (str as NSString).substring(with: r2)
        
        print(s + "\n" + link + "\n" + text)
    }
    
}

