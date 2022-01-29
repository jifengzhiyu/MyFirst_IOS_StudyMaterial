//
//  ViewController.swift
//  字符串
//
//  Created by 翟佳阳 on 2021/11/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        demo3()
    }

    //MARK: 字符串的子串
    func demo3(){
        let str = "Hello word"
        //as 转化类型
        let s1 = (str as NSString).substring(with: NSMakeRange(2, 5))
        //NSMakeRange(2, 5)
        //2 从第几个字符开始 5 截取5个字符
        print(s1)
        
        
    }
    
    
    //MARK: 格式化字符串
    func demo2(){
        
        let h = 8
        let m = 2
        let s = 6
        
        print("\(h)\(m)\(s)")
        
        let dateString = String(format: "%02d:%02d:%02d", h,m,s)
        print(dateString)
        
        let dateString1 = String(format: "%02d:%02d:%02d", arguments: [h,m,s])
        print(dateString1)
        
    }
    
    
    //MARK: 字符串拼接
    func demo1(){
        let name: String = "张三"
        let age = 10
        
        let center = view.center
        
        //字符串的拼接方式 \(变量名)
        print("\(name)\(age)\(center)")
    }
    

}

