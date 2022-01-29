//
//  String+Emoji.swift
//  emoji
//
//  Created by 翟佳阳 on 2021/12/9.
//

import Foundation
extension String{
    
    var emoji: String{
    //文本扫描-扫描指定格式的字符串
    let scanner = Scanner(string: self)
    
    //unicode值
    var value :UInt32 = 0
    scanner.scanHexInt32(&value)
    
    print(value)
    
    //转换unicode 字符
    let chr = Character(UnicodeScalar(value)!)
    print(chr)
    
    //传换成字符串
    return "\(chr)"
    }
}

extension NSString{
    
   
    
    @objc var emoji: NSString{
    //文本扫描-扫描指定格式的字符串
        let scanner = Scanner(string: self as String)
    
    //unicode值
    var value :UInt32 = 0
    scanner.scanHexInt32(&value)
    
    print(value)
    
    //转换unicode 字符
    let chr = Character(UnicodeScalar(value)!)
    print(chr)
    
    //传换成字符串
        return "\(chr)" as NSString
    }
}


 class Test2: NSObject {
     @objc func show() {
        print("hello bridge!");
    }
}
