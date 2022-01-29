//
//  ViewController.swift
//  闭包
//
//  Created by 翟佳阳 on 2021/11/17.
//

import UIKit
/**
    闭包 - 类似 OC 中的 block

    block
    - 是 c 语言的
    - 是一组预先准备好的代码，在需要的时候执行
    - 可以当作参数传递
    - 如果出现 self 需要注意循环引用

    在 Swift 中，函数本身就可以当作参数传递
*/
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 定义闭包
        /**
            1. 闭包的所有代码[参数 返回值 执行代码 都放在 {} 中
            2. in 是用来区分函数定义和执行代码
        
            格式
            { (参数名：参数类型) -> 返回值
              in
              // 代码执行 }
        */
        let sumFunc = {
            (num1: Int, num2: Int) -> Int
            in
            return num1 + num2
        }
        
        // 外部参数在定义 闭包的时候非常重要，能够有智能提示
        print(sumFunc(20, 60))
        
        // `简单`的闭包，如果没有参数和返回值，参数/返回值/in 都可以省略
        // () -> ()
        let demo = {
            print("hello")
        }
        
        demo()
    
    }
   
    func demo() {
        // 以下代码仅供参考，能看懂就好
        // 定义函数常量 (Int, y: Int) -> Int
        let sumFunc = sum
        let r = sumFunc(10, 20)
        
        print(r)

    }

    func sum(x: Int, y: Int) -> Int {
        return x + y
    }
    
}

