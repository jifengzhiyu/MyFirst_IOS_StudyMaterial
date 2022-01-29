//
//  Person.swift
//  KVC构造函数
//
//  Created by 翟佳阳 on 2021/11/18.
//

import UIKit

class Person: NSObject {
    // 对象的属性就是应该可变的
    // 可选项，允许变量为空，var 的默认值就是 nil
    // 在 iOS 开发中，所有的属性是延迟加载的
    
    //在Swift4.0之后，类必须要继承自NSObject,同时还需要在属性前面加上@objc
    @objc var name: String?
    
    // age 和 KVC 不兼容，OC中Int属于基本数据类型，不存在 `nil` 的概念
    @objc var age = 0
    
    //MARK: 便利构造函数
    // 构造函数中，如果出现 ?，表示这个构造函数不一定会创建出对象
    // convenience - 便利构造函数
    // 作用
    // 1. 能够提供条件检测
    // 2. 能够允许返回 nil，默认(指定)的构造函数，必须要创建对象
    // 3. 便利构造函数，必须在条件检测完成之后，以 self. 的方式调用其他的构造函数，创建对象
    // 4. 能够简化对象的创建方法
    convenience init?(name: String, age: Int) {
        
        if age < 0 || age > 100 {
            // 不能创建对象
            return nil
        }
        
        // 调用其他的构造函数初始化属性 － 在一个构造函数中调用了另外一个构造函数
        //考虑到可能子类会使用父类的遍历构造函数，这里调用self的指定构造函数，来确定是哪一个类的指定构造函数
        self.init(dict: ["name": name, "age": age])
    }
    
    
    
    //MARK: KVC 的构造函数
    /// KVC 的构造函数，用字典设置模型
    init(dict: [String : Any] ) {
        
        // KVC 是 OC 特有的，本质是在运行时，动态的给`对象`发送 `setVaule:forKey:` 消息
        // 设置数值 - 调用 super.init 保证对象已经被创建完成
        super.init()
        
        // KVC 的设置数值
        setValuesForKeys(dict)
    }

    

    
    override func setValue(_ value: Any?, forKey key: String) {
        print("forKey \(key) - \(String(describing: value))")
        super.setValue(value, forKey: key)
         
    }

    /// 默认的 setValue forUndefinedKey 方法如果出现未定义的key会抛出 `NSUndefinedKeyException`异常，让程序崩溃
    /// 如果一旦重写了此方法，同时不 super，不调用父类默认的方法！
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("forUndefinedKey \(key) \(String(describing: value))")
        
    }


    deinit{
        print("Person 88")
    }
    
}
