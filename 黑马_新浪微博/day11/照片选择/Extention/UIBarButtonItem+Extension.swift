//
//  UIBarButtonItem+Extension.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/13.
//

import UIKit

extension UIBarButtonItem {
    
    /// 便利构造函数
    ///
    /// - parameter imageName:  图像名
    /// - parameter target:     监听对象
    /// - parameter actionName: 监听图像名
    ///
    /// - returns: UIBarButtonItem
    convenience init(imageName: String, target: AnyObject?, actionName: String?) {
        let button = UIButton(imageName: imageName, backImageName: nil)
        
        // 判断 actionName
        if let actionName = actionName {
            button.addTarget(target, action: Selector(actionName), for: .touchUpInside)
        }
        
        self.init(customView: button)
    }
}

