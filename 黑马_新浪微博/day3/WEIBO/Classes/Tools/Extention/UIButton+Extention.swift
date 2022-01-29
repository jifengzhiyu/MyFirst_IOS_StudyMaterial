//
//  UIButton+Extention.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/24.
//

import UIKit

extension UIButton{
    /// `便利`构造函数
    ///
    /// - parameter imageName:     图像名称
    /// - parameter backImageName: 背景图像名称
    ///
    /// - returns: UIButton
    ///  /// - 备注：如果图像名称使用 "" 会抱错误 CUICatalog: Invalid asset name supplied:
    convenience init(imageName: String, backImageName: String?){
        self.init()
        
        setImage(UIImage.init(named: imageName), for: .normal)
        setImage(UIImage.init(named: imageName + "_highlighted"), for: .highlighted)
        
        if let backImageName = backImageName{
        setBackgroundImage(UIImage.init(named: backImageName), for: .normal)
        setBackgroundImage(UIImage.init(named:backImageName + "_highlighted"), for: .highlighted)
        }

        //根据背景图片大小调整尺寸
        sizeToFit()
    }
    
    /// 便利构造函数
    ///
    /// - parameter title:     title
    /// - parameter color:     color
    /// - parameter backImageName: imageName
    ///
    /// - returns: UIButton
    convenience init(title:String, color:UIColor, backImageName:String){
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setBackgroundImage(UIImage(named: backImageName), for: .normal)
        
    sizeToFit()
    }
    
    
    /// 便利构造函数
    ///
    /// - parameter title:     title
    /// - parameter color:     color
    /// - parameter fontSize:  字体大小
    /// - parameter imageName: 图像名称
    /// /// - parameter backColor: 背景颜色（默认为nil）
    /// - returns: UIButton
    convenience init(title: String, fontSize: CGFloat, color: UIColor, imageName: String?, backColor: UIColor? = nil) {
        self.init()
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        
        if let imageName = imageName {
        setImage(UIImage(named: imageName), for: .normal)
        }
        // 设置背景颜色
        backgroundColor = backColor
        
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        sizeToFit()
    }
    
}
