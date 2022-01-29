//
//  Person.swift
//  SQLite体验
//
//  Created by 翟佳阳 on 2021/12/20.
//

import UIKit

class Person: NSObject {
    @objc var id = 0
    @objc var name: String?
    @objc var age = 0
    @objc var height: Double = 0
    
    init(dict:[String : Any]){
        super.init()
        
        setValuesForKeys(dict)
    }
    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//
//    }
    
    override var description: String{
        let keys = ["id","name", "age", "height"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
    
    // MARK: - 数据库查询
    class func persons() -> [Person]? {
     
        // 1. 准备 SQL
        let sql = "SELECT id, name, age, height FROM T_Person;"
        
        // 2. 执行 SQL -> 字典的数组
        guard let array = SQLiteManager.sharedManager.execRecordSet(sql: sql) else {
            return nil
        }
        
        // 3. 遍历字典，字典转模型
        var arrayM = [Person]()
        
        for dict in array {
            arrayM.append(Person(dict: dict))
        }
        
        return arrayM
    }
    
    // MARK: - 数据库操作
    /// 将当前对象 id 对应的数据删除
    func deletePerson() -> Bool {

        // 1. 准备 SQL
        let sql = "DELETE FROM T_Person WHERE id = \(id);"
        
        // 2. 获得删除的数据行数
        let rows = SQLiteManager.sharedManager.execUpdate(sql: sql)
        
        print("删除数据行数 \(rows)")
        
        return rows > 0
    }
    
    /// 将当前对象 id 对应的数据进行修改
    func updatePerson() -> Bool {

        // 1. 准备 SQL
        let sql = "UPDATE T_Person SET name = '\(name!)', age = \(age), height = \(height) \n" +
            "WHERE id = \(id);"
        
        // 2. 执行 SQL - 记录影像的行数
        let rows = SQLiteManager.sharedManager.execUpdate(sql: sql)
        
        print("影响数据行数 \(rows)")
        
        return rows > 0
    }
    
    /// 将当前对象添加到数据库
    func insertPerson() -> Bool {
        
        // 1. 准备 SQL，如果是字符串，需要用 ''
        let sql = "INSERT INTO T_Person (name, age, height) VALUES ('\(name!)', \(age), \(height));"
        
        // 2. 执行 SQL - 返回 id
        id = SQLiteManager.sharedManager.execInsert(sql: sql)
        
        return id > 0
    }
}
