//
//  SoundTools.swift
//  OC单例
//
//  Created by 翟佳阳 on 2021/11/25.
//

import UIKit

class SoundTools: NSObject {
    // 在 Swift 中不允许在函数中定义静态成员

    //写法类似懒加载
    @objc static let sharedTools4 = SoundTools()
    
    // Swift 中的的单例写法和懒加载几乎一样 `static let`
    static let sharedTools3: SoundTools = {
        print("创建声音对象")
        return SoundTools()
    }()
    
    // 静态区的对象只能设置一次数值
    // 同样也是在第一次使用时，才会创建对象
    static let sharedTools2 = SoundTools()
    
    
    
}
