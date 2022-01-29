//
//  Person.swift
//  构造函数
//
//  Created by 翟佳阳 on 2021/11/18.
//

import UIKit

class Person: NSObject {
//可选项默认值为nil
    /**
        构造函数 － 建立一个`对象`
        1. 给属性分配空间
        2. 设置初始数值

        Swift 中构造函数`都`是 init
    */
    // 对象的属性就是应该可变的
    // 可选项，允许变量为空，var 的默认值就是 nil
    var name: String
    
    var age: Int
    //MARK: `重写`默认的构造函数
    
    // 父类提供了这个函数，而子类需要对父类的函数进行扩展，就叫做重写
    // 特点：可以 super.xxx 调用父类本身的方法
    override init() {
        print("Person init")

        name = "张三"
        age = 18
        
//         调用父类的构造函数
//        不写父类init也可以隐式调用
//         建议保留 super.init()，会让代码的调用线索很清晰
        super.init()
    }
        
        //MARK: 重载构造函数
        /// `重载的`构造函数，只要是构造函数，就需要给属性设置初始值
        /// 注意：如果重写了构造函数，系统默认提供的`构造函数 init()`，就不能再被访问
       
    init(name: String, age: Int){
        self.name = name
        self.age = age
        
    }
    
}
