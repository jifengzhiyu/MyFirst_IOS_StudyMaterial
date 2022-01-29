//
//  SQLiteManager.swift
//  SQLite体验
//
//  Created by 翟佳阳 on 2021/12/19.
//

import Foundation

/// SQLite 管理器
/**
    - SQLite 框架是纯 C 语言的框架
    - 所有函数都是以 sqlite3_ 开始的
*/
class SQLiteManager {
    /// 单例
    static let sharedManager = SQLiteManager()
    
    /// 全局数据库操作句柄
    private var db: OpaquePointer?
    
    /// 打开数据库
    ///
    /// - parameter dbName: 数据库文件名
    func openDB(dbName: String) {
        
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        path = (path as NSString).appendingPathComponent(dbName)
        
        print(path)
        
        /**
            参数
            1. 数据库的`全路径` Int8 -> uint8 -> Byte / char C语言的字符串
                但是：从 Xcode 7 beta 5 开始，可以使用 String 传递
            2. 全局数据库访问`句柄` -> 指针，后续所有对数据库的操作，全部基于此句柄
        
            返回值 如果 == SQLITE_OK 表示成功
        
            如果数据库不存在，会创建数据库，然后再打开数据库
            如果数据库存在，会直接打开数据库
        */
        if sqlite3_open(path, &db) != SQLITE_OK {
            print("打开数据库失败")
            return
        }
        
        // 创建数据表
        if createTable2() {
            print("创建数据表成功")
        } else {
            print("创建数据表失败")
        }
    }
    
    // MARK: - 数据查询操作

    /// 执行 SQL 返回数据结果集合
    func execRecordSet(sql: String) -> [[String: Any]]? {
        
        // 1. 预编译 SQL
        /**
            参数
            1. 全局数据库句柄
            2. 要执行 SQL 的 C 语言的字符串
            3. 要执行 SQL 的以字节为单位的长度，但是，如果传入 -1，SQLite 框架会自动计算
            4. STMT - 预编译的指令句柄
                - 后续针对`本次查询`所有操作，全部基于此句柄
                - 必须注意的，句柄一定要释放
                - 编译完成后，可以理解为一个临时的数据集合，通过 step 函数，能够顺序获取其中的结果
            5. 关于 STMT 尾部参数的指针，通常传入 nil
        
            返回值
            如果编译成功，表示 SQL 能够正常执行，返回 SQLITE_OK
        */
        
        var stmt: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sql, -1, &stmt, nil) != SQLITE_OK {
            print("SQL 错误")
            sqlite3_finalize(stmt)
            
            return nil
        }
        
        // 创建字典的数组
        var result = [[String: Any]]()
        
        // 单步执行获得结果 - ROW 对应一条完整的记录
        while sqlite3_step(stmt) == SQLITE_ROW {
            
            // 将字典记录添加到数组
            result.append(record(stmt: stmt!))
        }
        
//        print(result)
        
        // 释放 stmt
        sqlite3_finalize(stmt)
        
        // 返回结果
        return result
    }
    
    /// 从 stmt 中获取当前的记录内容
    /**
        提示：在获取一条记录的完整信息时，所有的函数开头都是 sqlite3_column_
    */
    private func record(stmt: OpaquePointer) -> [String: Any] {

        // 1. 知道记录的列数
        let cols = sqlite3_column_count(stmt)
//        print("列数 \(cols)")
        
        // 2. 创建单条记录的字典
        var row = [String: Any]()
        
        // 3. 循环每一列，获得每一列的对应内容
        for col in 0..<cols {
            // 1> 列名 Int8 / CChar / Byte
            let cName = sqlite3_column_name(stmt, col)
            let name = String(cString: cName!, encoding: String.Encoding.utf8)
            
            // 2> 数据类型
            let type = sqlite3_column_type(stmt, col)
//            print("type\(type)")
            var value: Any?
            switch type {
            case SQLITE_FLOAT:      // 小数
                value = sqlite3_column_double(stmt, col)
            case SQLITE_INTEGER:    // 整数
                value = Int(sqlite3_column_int64(stmt, col))
                //不会解决这个问题
//            case SQLITE3_TEXT:      // 字符串
//                // 记录 C 语言的字符串
//                let cText = sqlite3_column_text(stmt, col)
//                value = String(cString:  UnsafePointer<CChar>(cText!), encoding: String.Encoding.utf8)
            case SQLITE_NULL:       // 空值，一般数据库中允许字段为 nil，但是 OC 的字典不能插入 nil
                value = NSNull()    // NSNull 就是专门向字典和数组中插入控制使用的
            default:
                print("不支持的数据类型")
            }
            
//             print("\(name!) --- \(type) --- \(value)")
            // 取到一项内容，设置字典
            row[name!] = value
        }
        
//         print("row\(row)")
        
        return row
    }
    
    
    // MARK: - 数据操作函数
    /// 执行 SQL 更新 / 删除 数据
    ///
    /// - parameter sql: sql
    ///
    /// - returns: 返回修改 / 删除 的数据行数
    func execUpdate(sql: String) -> Int {
        
        // 1. 执行 SQL - 如果 SQL 错误会返回 -1
        if !execSQL(sql: sql) {
            // 执行失败，返回 -1
            return -1
        }
        
        // 2. 执行成功，返回影响的数据行数
        return Int(sqlite3_changes(db))
    }
    
    /// 执行 SQL 插入数据
    ///
    /// - parameter sql: sql
    ///
    /// - returns: 返回自动增长的 id
    func execInsert(sql: String) -> Int {
        
        // 1. 执行 SQL
        if !execSQL(sql: sql) {
            // 执行失败，返回 -1
            return -1
        }
        
        // 2. 执行成功，返回自动增长的 id － 最后一条插入数据的 id
        return Int(sqlite3_last_insert_rowid(db))
    }
    
    /// 执行 sql 指令
    ///
    /// - parameter sql: sql
    ///
    /// - returns: 返回是否正确
    func execSQL(sql: String) -> Bool {
        
        /**
            参数
        
            1. 数据库全局句柄
            2. 要执行的 SQL
            3. callback，执行完成 SQL 之后，调用的 C 语言函数指针，通常传入 nil
            4. 第三个参数 callback，函数参数的地址，通常传入 nil
            5. 错误信息，有其他方式获取执行情况，通常传入 nil
        
            返回值 如果 == SQLITE_OK 表示成功
        */
        return sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK
    }
    
    // MARK: - 创建数据表
    /// 创建数据表 - 商业应用程序主流的方法
    ///
    /// - returns: 是否成功
    private func createTable2() -> Bool {
        
        // 1. 从 bundle 中加载 sql 文件
        let path = Bundle.main.path(forResource: "db.sql", ofType: nil)!
        
        // 读取 SQL 的字符串
        let sql = try! String(contentsOfFile: path)
        
        // 2. 执行 SQL
        return execSQL(sql: sql)
    }
    
    /**
        调试技巧：
    
        1. 在开发数据库应用时，绝大多数出的问题，都是 SQL 的问题
        办法：把 sql 输出，借助 navicat 辅助做语法检查
        
        2. 拼接字符串的时候，末尾添加 '\n'，可以避免拼接字符串的时候，造成字符串连接错误
        \n 是一个有经验的数据库开发人员的好习惯！
    */
    private func createTable1() -> Bool {
        
        // 1. 准备 SQL
        let sql = "CREATE TABLE\n" +
            "IF NOT EXISTS 'T_Person' ( \n" +
            "'id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, \n" +
            "'name' TEXT, \n" +
            "'age' INTEGER, \n" +
            "'height' REAL, \n" +
            "'title' TEXT \n" +
            ");"
        
        print(sql)
        
        // 2. 执行 SQL
        return execSQL(sql: sql)
    }
}
