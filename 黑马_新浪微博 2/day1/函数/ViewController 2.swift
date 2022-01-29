//
//  ViewController.swift
//  函数
//
//  Created by 翟佳阳 on 2021/11/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(sum1(num1: 21, num2: 23))
        demo1()
        demo2()
        demo3()
        
    }

    /*
     没有返回值情况
    demo1，2，3
     */
    func demo1(){
        print("aaaaa")
    }
    
    func demo2() -> Void{
        print("bbbbb")
    }
    
    func demo3() -> (){
        print("ccc")
    }
    
    
    
    //参数类型不可以省略
    //函数名（参数名： 参数类型）->返回值类型
    func sum1(num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
    
   
}

