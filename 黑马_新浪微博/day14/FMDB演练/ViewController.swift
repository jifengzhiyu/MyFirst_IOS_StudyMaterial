//
//  ViewController.swift
//  FMDB演练
//
//  Created by 翟佳阳 on 2021/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        SQLiteManager.sharedManager
        
        // 注入演示
//        demoInsert1()
//        demoInsert2(name: "网舞', 0, 0); DELETE FROM T_Person; --")
//        demoInsert3()
//        demoInsert4(dict: ["id": 7, "name": "李四", "age": 18, "height": 1.9])
//        demoUpdate(dict: ["id": 1, "name": "李四", "age": 1800000, "height": 1.9])
//          demoDelete(id: 2)
        
//        persons1()
//        persons2()
//        persons3()
        manyPersons()
    }

    // MARK: - 事务处理
    func manyPersons() {
        
        print("开始")
        // 1. 准备 SQL
        let sql = "INSERT INTO T_Person (name, age, height) VALUES (:name, :age, :height);"
        
        let start = CACurrentMediaTime()
        
        // 2. 执行 SQL
        // OC 的写法 *stop = YES;
        // 1> Swift 的写法 rollback.memory = true
        // 2> FMDB的执行都是同步的！绝大多数开发时，不需要使用 block 回调
        // 3> 所有大数据量的插入，都应该使用事务！
        SQLiteManager.sharedManager.queue!.inTransaction { (db, rollback) -> Void in
            
            for i in 0..<10000 {
                let name = "张三 \(i)"
                let age = 20 + arc4random() % 20
                let height = 1.5 + Double(arc4random() % 5) / 10
                
                let dict = ["name": name, "age": age, "height": height] as [String : Any]
                
                if !db.executeUpdate(sql, withParameterDictionary: dict as [NSObject : Any]) {
                    // 回滚
                    rollback.pointee = true
                    
                    // break
                    break
                }
                
                // 模拟断电
                if i == 1000 {
                    rollback.pointee = true
                    break
                }
            }
        }
        
        print("over \(CACurrentMediaTime() - start)")
    }
    
    // MARK: 数据查询
    func persons3() {
        
        // 使用 FMDB 千万不要嵌套使用，否则一定死锁！
        // 1. 准备 SQL
        DispatchQueue.global().async {
            //多线程里面，三方框架自带串行队列
            //保证，可以开多个线程执行，并且按照添加的顺序依次执行,不用考虑线程冲突
            let sql = "SELECT id, name, age, height FROM T_Person;"
            
            let array = SQLiteManager.sharedManager.execRecordSet(sql: sql)
            
            print(array)
        }
    }
    
    func persons2() {
        // 1. 准备 SQL
        let sql = "SELECT id, name, age, height FROM T_Person;"
        
        // 2. 执行
        SQLiteManager.sharedManager.queue!.inDatabase { (db) -> Void in
            
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                print("没有结果")
                return
            }
            
            var result = [[String: Any]]()
            
            while rs.next() {
                // 1. 列数
                let colCount = rs.columnCount
                
                // 创建字典
                var dict = [String: Any]()
                
                // 2. 遍历每一列
                for col in 0..<colCount {
                    // 1> 列名
                    let name = rs.columnName(for: col)
                    // 2> 值
                    let obj = rs.object(forColumnIndex: col)
                    
                    // 3> 设置字典
                    dict[name!] = obj
                }
                // 将字典插入数组
                result.append(dict)
            }
            
            print(result)
        }
    }
    
    func persons1() {
        
        // 1. 准备 SQL
        let sql = "SELECT id, name, age, height FROM T_Person;"
        
        // 2. 执行
        SQLiteManager.sharedManager.queue!.inDatabase { (db) -> Void in
            
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                print("没有结果")
                return
            }
            
            // 逐行便利所有的数据结果 next 表示还有下一行
            while rs.next() {
                
                // 使用的函数名称取决于，需要的`返回值`
                let id = rs.int(forColumn: "id")
                let name = rs.string(forColumn: "name")
                let age = rs.int(forColumn: "age")
                let height = rs.double(forColumn: "height")
                
                print("\(id) \(String(describing: name!)) \(age) \(height)")
            }
        }
    }
    
    // MARK: - 基本数据操作
    //MARK: - 删除
    func demoDelete(id: Int) {
        
        // 1. 准备 SQL
        let sql = "DELETE FROM T_Person WHERE id = :id;"
        
        // 2. 执行 SQL
        SQLiteManager.sharedManager.queue!.inDatabase { (db) -> Void in
        
            if db.executeUpdate(sql, withArgumentsIn:[id]) {
                print("删除成功修改了 \(db.changes) 行")
            } else {
                print("失败")
            }
        }
    }
    
    //MARK: - 更新
    //根据id更新数据
    func demoUpdate(dict: [String: Any]) {
        
        // 1. 准备 SQL
        let sql = "UPDATE T_Person set name = :name, age = :age, height = :height \n" +
            "WHERE id = :id;"
        
        SQLiteManager.sharedManager.queue!.inDatabase { (db) -> Void in
            
            if db.executeUpdate(sql, withParameterDictionary: dict) {
                print("更新成功修改了 \(db.changes) 行")
            } else {
                print("失败")
            }
        }
    }
    
    //MARK: - 插入
    func demoInsert4(dict: [String: Any]) {
        /**
            FMDB 的特殊语法
        
            :key -> 与字典中的 key 相对应
        */
        let sql = "INSERT INTO T_Person (name, age, height) VALUES (:name, :age, :height);"
        
        SQLiteManager.sharedManager.queue!.inDatabase { (db) -> Void in
            
            if db.executeUpdate(sql, withParameterDictionary: dict) {
                print("执行 OK 自增长 id - \(db.lastInsertRowId)")
            } else {
                print("插入失败")
            }
        }
        
        print("OK")
    }
    
    /// 由于注入的原因，现在开发中，数据操作时，通常会使用绑定参数的形式
    func demoInsert3() {
        
        // 1. SQL
        /**
            ? 表示占位符号
        
            - SQLite 首先编译 SQL，再执行的时候，动态绑定数据，同样可以避免`注入`
            - 使用占位符操作，不需要单引号
        */
        let sql = "INSERT INTO T_Person (name, age, height) VALUES (?, ?, ?);"
        
        SQLiteManager.sharedManager.queue?.inDatabase { (db) -> Void in
    
            if db.executeUpdate(sql, withArgumentsIn: ["网舞', 0, 0); DELETE FROM T_Person; --", 18, 1.9]){
                print("执行 OK 自增长 id - \(db.lastInsertRowId)")
            } else {
                print("插入失败")
            }
        }
        
        print("OK")
    }
    
    /// SQL `注入`演示
    func demoInsert2(name: String) {
        
        // 1. SQL
        let sql = "INSERT INTO T_Person (name, age, height) VALUES ('\(name)', 18, 1.8);"
        
        print(sql)
        
        // 2. 执行 SQL
        SQLiteManager.sharedManager.queue?.inDatabase { (db) -> Void in
            
            // 在程序执行中，最好不要使用 executeStatements
            // 使用 executeUpdate 会更安全！
            try!db.executeUpdate(sql, values: nil)
        }
        
        print("OK")
    }
    
    func demoInsert1() {
        
        // 1. SQL
        let sql = "INSERT INTO T_Person (name, age, height) VALUES ('张三', 18, 1.8);"
        
        // 2. 执行 SQL
        SQLiteManager.sharedManager.queue?.inDatabase { (db) -> Void in
            
            // 在程序执行中，最好不要使用 executeStatements
            db.executeStatements(sql)
        }
    }
}

