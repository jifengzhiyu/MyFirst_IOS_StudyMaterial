//
//  Student.swift
//  构造函数
//
//  Created by 翟佳阳 on 2021/11/18.
//

import UIKit

class Student: Person {
    var no: String
    
    
    /// 如果父类没有实现 init() 函数，因此不能直接重写
    override init() {
        no = "01"
        // 建议保留 super.init()，会让代码的调用线索很清晰
        super.init()

        print("学生")
    }
    
    // 重写父类方法 ❌无法重写父类的构造函数
    //Initializer does not override a designated initializer from its superclass
//    override init(name: String, age: Int) {
//
//        no = "002"
//
//        super.init(name: name, age: age)
//    }
    
    init(name: String, age: Int, no: String) {
        
        self.no = no
        
        // 调用父类的方法，设置父类的属性
        super.init(name: name, age: age)
    }
    
}
