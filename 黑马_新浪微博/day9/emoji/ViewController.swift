//
//  ViewController.swift
//  emoji
//
//  Created by 翟佳阳 on 2021/12/9.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let str = "0x1f603"
        
        print(str.emoji)
        
       
    }

    func demo(){
        //16进制 字符串
        let str = "0x1f603"
        
        //文本扫描-扫描指定格式的字符串
        let scanner = Scanner(string: str)
        
        //unicode值
        var value :UInt32 = 0
        scanner.scanHexInt32(&value)
        
        print(value)
        
        //转换unicode 字符
        let chr = Character(UnicodeScalar(value)!)
        print(chr)
        
        //传换成字符串
        let result = "\(chr)"
        print(result)
    }

}

