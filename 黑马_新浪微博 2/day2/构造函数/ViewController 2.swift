//
//  ViewController.swift
//  构造函数
//
//  Created by 翟佳阳 on 2021/11/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //MARK: `重写`默认的构造函数
//        let p = Person()
        

//        print("person: \(p.name) --- \(p.age)")

//        let s = Student()
        let s = Student(name: "爱不爱", age: 21, no: "1111111")

        print("Student: \(s.name) --- \(s.age) --- \(s.no)")
        
        //MARK: 重载构造函数
        /*
         重载：OC中没有重载的概念

         函数名相同，参数的个数&类型不同，叫做重载，是面向对象设计语言必备标志！
         OC 中使用 initWithXXX的方式替代
         */
        
        let p = Person(name: "哈呀", age: 12)
        
        print("person: \(p.name) --- \(p.age)")
        
        
        
        
        
    }


}

