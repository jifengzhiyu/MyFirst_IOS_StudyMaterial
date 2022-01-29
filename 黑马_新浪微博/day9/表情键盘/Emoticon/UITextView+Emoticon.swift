//
//  UITextView+Emoticon.swift
//  表情键盘
//
//  Created by 翟佳阳 on 2021/12/13
import UIKit

extension UITextView{
    /// 图片表情完整字符串内容
    var emoticonText: String {
        
//        print(textView.text ?? "")
//        print(textView.attributedText ?? "")
        var strM = String()
        
        let attrText = attributedText
        
        
        // 遍历属性文本
        attrText!.enumerateAttributes(in: NSRange(location: 0, length: attrText!.length),
            options: []) { (dict, range, _) -> Void in
                
                // 分段循环的调试技巧
                print("-----")
                // 调试结论：如果字典中包含 NSAttachment 说明是图片
                // 否则是字符串，可以通过 range 获得
                // 新问题：如何在 attachment 中增加 `哈哈`
            if let attachment = dict[NSAttributedString.Key(rawValue: "NSAttachment")] as? EmoticonAttachment {
                    print("图片 \(attachment.emoticon)")
                    
                    strM += attachment.emoticon.chs ?? ""
                } else {
                    let str = (attrText!.string as NSString).substring(with: range)

                    strM += str
                }
        }
        
        print("最终结果 \(strM)")
        return strM
        
    }
    
    /// 插入表情符号
    ///
    /// - parameter em: 表情模型
    func insertEmoticon(em: Emoticon) {
        
//        print(em)
        
        // 1. 空白表情
        if em.isEmpty {
            return
        }
        
        // 2. 删除按钮
        if em.isRemoved {
            deleteBackward()
            return
        }
        
        // 3. emoji
        if let emoji = em.emoji {
            replace(selectedTextRange!, withText: emoji)
            
            return
        }
//        text = em.chs
        
        // 4. 图片表情
        insertImageEmoticon(em: em)
        
        // 5. 通知`代理`文本变化了 － textViewDidChange? 表示代理如果没有实现方法，就什么都不做，更安全
        delegate?.textViewDidChange?(self)
    }
    
    // 插入图片表情
    private func insertImageEmoticon(em: Emoticon) {
        
        print(em)
        
//        // 1. 图片的属性文本
////        let attachment = EmoticonAttachment(emoticon: em)
//        let attachment = EmoticonAttachment(emoticon: em)
//
//        attachment.image = UIImage(contentsOfFile: em.imagePath)
//
//        // `线高`表示字体的高度
//        let lineHeight = font!.lineHeight
//        // frame = center + bounds * transform
//        // bounds(x, y) = contentOffset
//        attachment.bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
////
////        // 获得图片文本
//        let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
//        // `添加`字体 - UIKit.framework 第一个头文件
//        imageText.addAttribute(NSAttributedString.Key.font, value: font!, range: NSRange(location: 0, length: 1))
        let imageText = EmoticonAttachment(emoticon: em).imageText(font: font!)
//
//        // 2. 记录 textView attributeString －> 转换成可变文本
        let strM = NSMutableAttributedString(attributedString: attributedText)
//
//        // 3. 插入图片文本
        strM.replaceCharacters(in: selectedRange, with: imageText)
//
//        // 4. 替换属性文本
//        // 1) 记录住`光标`位置
        let range = selectedRange
//        // 2) 替换文本
        attributedText = strM
//        // 3) 恢复光标
        selectedRange = NSRange(location: range.location + 1, length: 0)
        
    }
}
