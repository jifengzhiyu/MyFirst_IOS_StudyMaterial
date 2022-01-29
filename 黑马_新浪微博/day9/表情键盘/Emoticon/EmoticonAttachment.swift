//
//  EmoticonAttachment.swift
//  表情键盘
//
//  Created by 翟佳阳 on 2021/12/13.
//

import UIKit
/// 表情附件
class EmoticonAttachment: NSTextAttachment {
    /// 表情模型
    var emoticon: Emoticon
    
    /// 将当前附件中的 emoticon 转换成属性文本
    func imageText(font:UIFont) -> NSAttributedString{
        // 1. 图片的属性文本
//        let attachment = EmoticonAttachment(emoticon: em)
//        let attachment = EmoticonAttachment(emoticon: em)
        
        image = UIImage(contentsOfFile: emoticon.imagePath)
        
        // `线高`表示字体的高度
        let lineHeight = font.lineHeight
        // frame = center + bounds * transform
        // bounds(x, y) = contentOffset
        bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
//
//        // 获得图片文本
        let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: self))
        // `添加`字体 - UIKit.framework 第一个头文件
        imageText.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: 1))
        
        return imageText
    }
    
    //MARK: - 构造函数
    init(emoticon: Emoticon) {
        self.emoticon = emoticon
        
        super.init(data: nil, ofType: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
