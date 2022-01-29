//
//  UIColor+Extension.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/16.
//

import UIKit

extension UIColor {
    //类函数
    class func randomColor() -> UIColor {
        
        // 0~255
        let r = CGFloat(arc4random() % 256) / 255.0
        let g = CGFloat(arc4random() % 256) / 255.0
        let b = CGFloat(arc4random() % 256) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
