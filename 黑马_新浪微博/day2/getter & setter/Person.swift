//
//  Person.swift
//  getter & setter
//
//  Created by 翟佳阳 on 2021/11/20.
//

import UIKit

class Person: NSObject {
    // -- getter & setter 方法在 Swift 中极少用，仅供参考
    // OC 中利用 getter 方法，编写懒加载，而 Swift 中提供了 lazy
    
    // 如果不希望暴露的方法或者属性，都需要用 private 保护起来！
    
    private var _name: String?
    var name: String? {
        
        get{
            // 返回 _成员变量 的值
            return _name
        }
        
        set{
            // 使用 _成员变量记录新的数值
            _name = newValue
        }
    }
    
    //因为本身 就有了可以使用的setter getter，
    var name2: String?
    
    // -- read only 属性，只写 getter 方法
    // Swift 中 get only 属性
    var title: String?{
        get{
            return "Mr " + (name ?? "")
        }
    }
    
    //MARK: 只读属性的简写方法
    // 只读属性的简写方法 - 如果属性的`修饰`方法，只提供 getter，那么 get {} 可以省略
    // 另外一种叫法：`计算`型属性
    // 每一次调用的时候，都会执行 {} 中的代码，`结果取决于其他属性或者原因`
    // * 每次都要计算，浪费性能 － 如果计算量很小，可以使用
    // * 不需要开辟额外的空间
    var title2: String?{
        return "Mr " + (name ?? "")
    }


    //MARK: 懒加载
    // 懒加载 － 第一次调用的时候，执行闭包，并且在 title3 中保存闭包执行结果
    // 再次调用，不再执行闭包，而是直接返回之前计算的结果！
    // * 只需要计算一次
    // * 需要开辟单独的空间保存计算结果
    // * 闭包的代码，再也不会被调用！
    // * 如果计算量很大，需要提前准备
    lazy var title3: String? = {
        // 闭包：是一个提前准备好的代码，在需要的时候执行
        // 使用 self. 用于闭包在执行时，准确的绑定对象
        // 闭包中的 self. 是不能省略的！
        return "Mr " + (self.name ?? "")
    }()
    
}

