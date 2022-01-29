//
//  String+Regex.swift
//  正则demo
//
//  Created by 翟佳阳 on 2021/12/25.
//

import Foundation

extension String {
    
    /// 从当前字符串中，过滤链接和文字
    /// 元组，可以允许一个函数返回多个数值
    func href() -> (link: String, text: String)? {
        
        // 1. 创建正则表达式
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        
        // throws 针对 pattern 是否正确的异常处理
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        // firstMatchInString 在 指定的字符串中，查找第一个和 pattern 符合字符串
        guard let result = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) else {
            print("没有匹配项目")
            return nil
        }
        
        let str = self as NSString
        
        let r1 = result.range(at: 1)
        let link = str.substring(with: r1)
        
        let r2 = result.range(at: 2)
        let text = str.substring(with: r2)
        
        return (link, text)
    }
}
