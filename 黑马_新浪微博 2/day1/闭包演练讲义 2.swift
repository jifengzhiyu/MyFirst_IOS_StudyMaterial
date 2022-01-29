//
//  ViewController.swift
//  11-闭包演练
//
//  Created by male on 15/10/11.
//  Copyright © 2015年 itheima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData2 { (html) -> () in
            print("完成回调代码 \(html)")
        }
        
        loadData3()
    }
    
    // `尾`随闭包 - 不要求自己写，但是，要求必须能看懂
    // 1. 闭包最后一个参数
    // 2. 函数 的 ) 前置到倒数第二个参数末尾
    // 3. 最后一个逗号省略
    // 补充，简化闭包，如果没有参数，没有返回值，可以省略() -> ()
    //尾随闭包：可以去掉函数最后的 ），改到倒数第二个参数后面，取代倒数第二个参数后的逗号，函数结束使用}
    
    func loadData3() {
        
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            print("hehe")
        }
        
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            print("haha")
            
            dispatch_sync(dispatch_get_main_queue()) {
                print("主线程回调")
            }
        }
    }
    
    // block / 闭包的应用场景
    // 通常用在异步加载网络数据，完成回调 －> 以 参数 的形式 传递网络获取的数据
    func loadData2(finished: (html: String) -> ()) {
        
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            print("耗时操作 \(NSThread.currentThread())")
            
            // 通常加载数据...
            
            // 异步完成之后，通过 block 回调
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("完成 \(NSThread.currentThread())")
                
                // 执行 finished 回调
                finished(html: "<html></html>")
            })
        }
    }

    // block / 闭包的应用场景
    // 通常用在异步加载网络数据，完成回调
    func loadData(finished: () -> ()) {
        
        dispatch_async(dispatch_get_global_queue(0, 0)) { () -> Void in
            print("耗时操作 \(NSThread.currentThread())")
            
            // 通常加载数据...
            
            // 异步完成之后，通过 block 回调
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                print("完成 \(NSThread.currentThread())")
                
                // 执行 finished 回调
                finished()
            })
        }
    }
}

