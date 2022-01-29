//
//  ViewController.swift
//  SQLite体验
//
//  Created by 翟佳阳 on 2021/12/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        demoInsert()
//        demoUpdate()
//          demoDelete()
        
//        print(Person.persons() ?? "")
//        print("---------")
        //转化成NSArray打印下来更好看
//        print((Person.persons() ?? []) as NSArray)
        
//        manyPersons1()
//          manyPersons2()
//          manyPerson3()
        manyPerson4()
        
    }

    // 真实开发的代码
    func manyPerson4() {
        
        // 取绝对时间的函数
        // CFAbsoluteTimeGetCurrent()   - 会收到`系统服务`的影响，在做性能测试的时候，可能会有误差！
        // CACurrentMediaTime           - 只和硬件时间有关，做性能测试更准确！
        // 1. 开始时间
        let start = CACurrentMediaTime()
        print("开始")
        
        // 开启事务
        SQLiteManager.sharedManager.execSQL(sql: "BEGIN TRANSACTION;")
        
        for i in 0..<10000 {
            let p = Person(dict: ["name": "张三 - \(i)", "age": 18, "height": 1.7])
            
            // 插入数据失败
            if !p.insertPerson() {
                // 回滚事务
                SQLiteManager.sharedManager.execSQL(sql: "ROLLBACK TRANSACTION;")
                // 退出循环 － 非常非常重要！
                break
            }
        }
        
        // 提交事务
        SQLiteManager.sharedManager.execSQL(sql: "COMMIT TRANSACTION;")
        
        // 2. 结束时间
        print("完成 \(CACurrentMediaTime() - start)")
    }
    
    /// 模拟失败
    ///     /// 不算这次的修改，还是上一次的修改
    func manyPerson3() {
        // 1. 开始时间
        let start = CACurrentMediaTime()
        print("开始")
        
        // 开启事务
        SQLiteManager.sharedManager.execSQL(sql: "BEGIN TRANSACTION;")
        
        for i in 0..<10000 {
            Person(dict: ["name": "张三 - \(i)", "age": 18, "height": 1.7]).insertPerson()
            
            if i == 1000 {  // 停电了
                // 回滚事务
                SQLiteManager.sharedManager.execSQL(sql: "ROLLBACK TRANSACTION;")
                // 退出循环 － 非常非常重要！
                break
            }
        }
        
        // 提交事务
        SQLiteManager.sharedManager.execSQL(sql: "COMMIT TRANSACTION;")
        
        // 2. 结束时间
        print("完成 \(CACurrentMediaTime() - start)")
    }
    
    // 面试题：如果一次性向数据库中插入大量数据，应该如何处理？
    // 利用事务插入数据，就可以了，亲测时间
    /**
        事务
        
        1. 在 SQLite 数据库操作中，如果`不显式`开启事务，每一条数据库的操作指令都会开启事务，执行完毕后，提交事务
        2. 如果 显式 的开启事务，SQLite 不再开启事务
    */
    /// 插入大量数据 - 使用事务只需要 0.7s
    func manyPersons2() {
        
        // 1. 开始时间
        let start = CACurrentMediaTime()
        print("开始")
        
        // 开启事务
        SQLiteManager.sharedManager.execSQL(sql: "BEGIN TRANSACTION;")
        
        for i in 0..<10000 {
            Person(dict: ["name": "张三 - \(i)", "age": 18, "height": 1.7]).insertPerson()
        }
        
        // 提交事务，数据库操作正常情况下
        SQLiteManager.sharedManager.execSQL(sql: "COMMIT TRANSACTION;")
        
        // 2. 结束时间
        print("完成 \(CACurrentMediaTime() - start)")
    }
    
    
    /// 插入大量数据 - 测试结果 39s
    func manyPersons1() {
        
        // 1. 开始时间
        let start = CACurrentMediaTime()
        print("开始")
        
        for i in 0..<10000 {
            Person(dict: ["name": "张三 - \(i)", "age": 18, "height": 1.7]).insertPerson()
        }
        
        // 2. 结束时间
        print("完成 \(CACurrentMediaTime() - start)")
    }
    
    func demoDelete() {
        let p = Person(dict: ["id": 5, "name": "李四", "age": 180, "height": 1.7])
         
        if p.deletePerson() {
            print("删除成功")
        } else {
            print("删除失败")
        }
    }
    
    func demoUpdate() {
        
        let p = Person(dict: ["id": 3, "name": "李四", "age": 180, "height": 1.7])
        
        if p.updatePerson() {
            print("更新成功")
        } else {
            print("更新失败")
        }
    }

    func demoInsert() {
        
        let p = Person(dict: ["name": "张三", "age": 18, "height": 1.7])
        
        if p.insertPerson() {
            print("插入成功 \(p)")
        } else {
            print("插入失败")
        }
    }
}

