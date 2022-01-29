//
//  ViewController.swift
//  闭包
//
//  Created by 翟佳阳 on 2021/12/4.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 2. loadData 的参数，是一个 demo 函数的首地址
//        loadData(finished: demo)
        
//        loadData (finished: {
//            () -> () in
//            print("hi")
//        })
        
//        loadData(finished: demo)
//        loadData (finished: { name in
//            print("hi " + name)
//        })
//        loadData(finished: demo)
        
        loadData (finished: { text in
            print("hello " + text)
               
               if text == "爱不爱"{
                   return 11
               }else{
                   return 22
               }
            // 都会对 外部变量做一次 copy
            self.view.backgroundColor = .white
            
        })
    }

    /**
        1. 函数名是什么？是指向代码区的指针地址
        2. 如果要执行函数，通过函数地址，找到第一句代码行
    */
//    func demo() -> (){
//        print("hello")
//    }
//    func demo(name: String) -> (){
//     print("hello " + name)
//    }
    func demo(name: String) -> Int{
     print("hello " + name)
        
        if name == "爱不爱"{
            return 11
        }else{
            return 22
        }
    }
    
    /// 加载数据
    ///
    /// - parameter finished: 完成回调
    /// 行参接收的值是 demo 函数的地址
//    func loadData(finished: () -> ()){
//        // 执行闭包 -> 通过函数地址运行
//        // finished 是指向 demo 的地址
//        finished()
//    }
    
//    func loadData(finished: (_ text: String) -> ()){
//        // 执行闭包 -> 通过函数地址运行
//        // finished 是指向 demo 的地址
//        finished("爱不爱")
//    }
    func loadData(finished: (_ text: String) -> Int){
        // 执行闭包 -> 通过函数地址运行
        // finished 是指向 demo 的地址
        let age = finished("爱不爱")
        
        if age > 11{
            print("奔三了")
        }else{
            print("要要要")
        }
    }
}

