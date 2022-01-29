//
//  Person.swift
//  通讯录
//
//  Created by 翟佳阳 on 2021/11/20.
//

import UIKit

class Person: NSObject {
    @objc var name:String?
    @objc var age: Int = 0
    
    init(dict: [String: Any]){
        super.init()
        
        setValuesForKeys(dict)
    }
    
    // 对象描述信息 － 有利于开发调试的
    // 类似于 java 中的 toString() 函数，在很多公司中，是在开发规范中要求必写！
    // iOS 开发时，应该在模型类中实现此属性/方法
    //description的getter
    override var description: String {
        let keys = ["name", "age"]
        
        // 模型转字典 - 网络的 POST JSON
        return "\(dictionaryWithValues(forKeys: keys))"
    }
}
