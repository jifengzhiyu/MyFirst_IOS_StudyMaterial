//
//  ViewController.swift
//  myFristSwiftAPP
//
//  Created by 翟佳阳 on 2021/11/16.
//

import UIKit
/**
0. Swift中，不需要分号，在其他语言中，`;`的作用是表示一句指令结束
    如果多个语句并列，可以使用分号

1. OC 中，alloc / init 对应在 ()，构造函数，创建并且初始化对象
2. OC 中，alloc / initWithXXX，Swift 中 (XXX: )
3. OC 中，[UIColor redColor] 类函数，在 Swift 中直接用 .
4. 枚举类型 UIButtonTypeContactAdd，Swift中分开写，[回车－> 向右－> .]
    直接 . 很多时候，没有智能提示！
5. print 类似于 OC 的 NSLog，但是效率更高
6. 添加监听方法，直接用 "方法名"，如果有参数 "方法名:"

7. Swift 中，可以省略 self.，加上也可以，个人建议，最好不要加，`闭包`中必须要 self.
*/
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        demo9()
        
    

    }
    
    //MARK: 可选项替换
    func demo9(){
    // var 的可选项默认值是 nil
    // let 的可选项没有默认值，必须要设置初始值
    var oName: String?  = "老王"
    // 定义常量的时候，如果只指定了类型，没有设置初始值，可以有一次设置机会
    //oName = "老李"
    // 再次设置会报错
//        oName = "张xx"
    
    if oName != nil {
        print(oName! + " 好!")
    }
    
    // ?? 操作符号，可以判断之前的变量是否为 nil，如果为 nil，使用后面的替换
    print((oName ?? "") + "也好!")
    
    print("-------")
    // ?? 运算符号优先级`低`
    print(oName ?? "" + "也好!")
}
    
    //MARK: switchDemo
    func switchDemo() {
        
        // option + click 是开发中最重要的组合键
        let number = "11"
        
        /**
            1. 不需要 break
            2. 不在局限在 对 int 的分支，可以对任意数据类型进行检测
            3. 各个 case 之间，不会穿透，如果有多个值，使用 , 分隔
            4. 定义变量，不需要使用 {} 分隔作用域
            5. 在 swift 中，必须涵盖所有条件，每一个 case 至少包含一条语句
        */
        switch number {
        case "10", "11":
            let name = "老王"
            print("\(name) 好")
        case "9": print("良")
        default: break
//            print("差")
        }
        
    }
    
    //MARK: guard － 是和 if let 刚好相反的指令
    /// Swift 2.0 推出的语法
    func demo8() {
        let oName: String? = "张三"
        let oAge: Int? = 20
        
        //oName没有值执行else语句
        guard let name = oName else {
            print("name 为 nil")
            return
        }
        
        guard let age = oAge else {
            print("age 为 nil")
            return
        }
        
        // 代码执行到此,name 和 age 一定有值
        // 在实际开发中，复杂的代码在条件判断之后
        // 使用 guard 会让嵌套层次少一层！
        print("Hi \(name) --- \(age)")
    }
    
    
    //MARK: if let
    func demo7() {
        //可选项
        let oName: String? = "张三"
        var oAge: Int?
        
        if oName != nil && oAge != nil {
            print("Mr" + oName! + "---" + String(oAge!))
        }
        
        // if let 可以设置数值，进入if分支后，name 可以保证一定有值
        if let name = oName {
            print("Hi " + name)
        }
        
        if let age = oAge {
            print("Hi "  + String(age))
        }
        
        // 多值的设置，使用 , 分隔
        // 注意：if let 语句中不能使用 && || 条件
        //oName,oAge都有值的情况下，执行条件句
        if let name = oName, let age = oAge {
            print("Hi " + name + "---" + String(age))
        }
    }
    
    // MARK: 三目
    /// 三目 - 在 Swift 中，用的很多！
    // if 语句，一不小心会写的丑疯了！
    func demo6() {
        
        let a = 2
        //3. 条件判断，C 语言中有一个非零即真，Swift 中只有 true / false
        //所以下面的是错的
        //a > 5 ? print("哈哈") : print("呵呵")
    }
    
    // MARK: 基本的 if
    func demo5() {
        
        let x = 10
        
        /**
            1. 没有 ()
            2. 必须要有 {}
                在很多公司的开发规范中，都是禁止不使用 {} 的！
            3. 条件判断，C 语言中有一个非零即真，Swift 中只有 true / false
        */
        if x > 5 {
            print("xxx")
        }
        
        if x > 20 {
            print("大了")
        } else {
            print("小了")
        }
    }

    
    // MARK: 可选项
    /**
        提示：可选项是所有 OC 的程序员刚接触 Swift 时候，最头疼的问题！
    
        - 1. 明确可选项的概念！
        - 2. 实际开发中，借助 Xcode 智能提示，帮助修改！
        - 3. 每次修改，都要思考为什么！
    */
func demo4() {
        let urlString = "http://www.baidu.com"
        // 注意：构造函数如果有 `?` 表示不一定能够创建出对象
        let url = NSURL(string: urlString)
        
        print(url!)
        
        // 注意：如果参数中，没有 ? 表示必须要有值，如果为 nil，就崩！
        if url != nil {
            let request = NSURLRequest(url: url! as URL)

            print(request)
        }
    }
    
    // 可选项：一个变量，可以为本身的类型，也可以为 nil
    func demo3() {
        
        // 定义变量／常量如果需要指定类型 : 类型 的方式指定准确的类型
        var x: Double = 20
        x = 29
        print(x + 1.5)
        
        // 可选项 使用 ? 定义
        // y 可以是一个整数/也可以是 nil，如果是变量，默认是 nil
        // 注意：可选项在输出的时候，会提示 `Optional`
        let y: Int? = 10
        
        print(y!)
        
        // * 可选项不能直接计算
        // ! － `强行解包 unwrapping` - 程序员承诺 y 一定有值，如果没有，崩给我看！
        // unexpectedly found nil while unwrapping an Optional value
        // 每次写 ! 的时候，都需要程序员思考，是不是有可能为 nil!
        print(y! + 20)
    }
    
    // MARK: 基础变量
    func demo2() {
        // 自动推导 - 会根据设置数值的右侧代码，推断变量/常量的类型
        // 但是：在 Swift 中，任何时候，都不会做隐式转换
        // 任何两个类型不同的变量或者常量不允许直接计算！- Swift 是一个类型要求异常严格的语言！
        
        // 整数默认是 Int -> 64位整数 long
        let x = 20
        // 小数默认是 Double -> 双精度的小数，OC 中使用 CGFloat 比较多，浮点数
        let y = 1.5
        let r1 = x + Int(y)
        print(r1)
        
        let r2 = Double(x) + y
        print(r2)
    }
    
    // 基本使用
    func demo() {
        // let 定义常量 - 一旦设置数值，不允许修改
        // var 定义变量 - 可以修改
        // 问题：let & var 如何选择，尽量用 let，必须要修改的时候，再用 var，程序更安全
        let x = 20
//        x = 30
        
        var y = 30
        y = 80
        
        print(x + y)
        
        // 视图实例化之后，并没有修改指针地址
        let v = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        // 只是在修改属性
        v.backgroundColor = UIColor.red
        
    }
}

