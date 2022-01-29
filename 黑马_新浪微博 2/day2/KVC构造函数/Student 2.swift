//
//  Student.swift
//  KVC构造函数
//
//  Created by 翟佳阳 on 2021/11/19.
//

import UIKit

class Student: Person {
    
    /// 如果子类没有实现父类的方法，在执行时，会直接调用父类的方法
    @objc var no: String?
    
    // 如果子类没有实现便利构造函数，调用方同样可以使用 父类的 便利构造函数，实例化子类对象
    //此时，子类单独的属性是nil
    
    // 便利构造函数，不能被继承，也不能被重写！
    //服务于本类
    //判断本类条件
    
    //== OC dealloc
    deinit{
        print("student 88")
    }
}
