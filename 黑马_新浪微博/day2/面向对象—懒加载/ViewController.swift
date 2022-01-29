//
//  ViewController.swift
//  面向对象—懒加载
//
//  Created by 翟佳阳 on 2021/11/20.
//

import UIKit

class ViewController: UIViewController {

    // `懒`加载 - 本质上是一个闭包
    /**
        第一次访问属性时，会执行后面的闭包代码，将闭包的`结果`保存在 person 属性中
        下次再访问，不会再执行闭包！
    
        如果没有lazy，会在 initWithCoder 方法中被调用，当 二进制的 storyboard 被还原成视图控制器对象之后，就会被调用
    
        提示：在开始的时候，可以先尝试记忆语法！
    */
    lazy var person: Person = {
        print("懒加载")
        return Person()
    }()
    
    // 懒加载的简单写法
    lazy var demoPerson: Person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        print(person)
        print(demoPerson)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(person)
        print(demoPerson)

    }


}

