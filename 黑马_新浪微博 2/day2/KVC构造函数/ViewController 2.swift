//
//  ViewController.swift
//  KVC构造函数
//
//  Created by 翟佳阳 on 2021/11/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
//        let p = Person(dict: ["name": "网舞", "age": 190, "title": "hahah", "no": "009"])
        let p = Student(name: "爱上", age: 18)
//        let p = Student(dict: ["name": "网舞", "age": 19, "title": "hahah", "no": "009"])

//        print("\(String(describing: p.name)) -- \(p.age) -- \(String(describing: p.no))")
        
        
        // 解包使用 ? 表示如果 p 为 nil，不继续调用后续的属性或者方法
        print("\(String(describing: p?.name)) --- \(String(describing: p?.age)) -- \(String(describing: p?.no))")
        
    }
        
    


}

