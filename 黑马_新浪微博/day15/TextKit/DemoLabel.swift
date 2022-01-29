//
//  DemoLabel.swift
//  TextKit
//
//  Created by 翟佳阳 on 2021/12/25.
//

import UIKit

class DemoLabel: UILabel {

    // MARK: - 重写属性
    override var text: String? {
        didSet {
            prepareText()
        }
    }
    
    override var attributedText: NSAttributedString? {
        didSet {
            prepareText()
        }
    }
    
    // MARK: - 绘制文本
    override func drawText(in rect: CGRect) {
     
        let range = NSRange(location: 0, length: textStorage.length)
        
        // 绘制字形 － 布局管理器绘制 textStorage 中的内容
        layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint.zero)
    }
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareTextSystem()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        prepareTextSystem()
    }
    
    /// 准备文本系统
    private func prepareTextSystem() {
        
        // 1. 准备文本内容
        prepareText()
        
        // 2. 设置对象关系
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
    }
    
    /// 准备文本内容
    private func prepareText() {
        
        if attributedText != nil {  // 直接设置属性文本
            textStorage.setAttributedString(attributedText!)
        } else if text != nil {
            textStorage.setAttributedString(NSAttributedString(string: text!))
        } else {
            textStorage.setAttributedString(NSAttributedString(string: ""))
        }
        
        print(rangeForUrls)
        // 遍历 url 数组，设置文本属性
        for range in rangeForUrls {
            textStorage.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: range)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置文本容器的尺寸
        textContainer.size = bounds.size
    }
    
    // MARK: - 懒加载属性
    /// 文本内容 - 可变属性字符串的子类
    private lazy var textStorage = NSTextStorage()
    /// 布局管理器 - 负责文本绘制
    private lazy var layoutManager = NSLayoutManager()
    /// 文本容器 - 设置绘制的尺寸
    private lazy var textContainer = NSTextContainer()
}

// MARK: - 正则表达式相关函数/属性
extension DemoLabel {
    
    /// 返回字符串中所有 URL 链接的范围数组
    var rangeForUrls: [NSRange] {
        
        // 1. 定义正则表达式
        let pattern = "[a-zA-Z]*://[a-zA-Z0-9/\\.]*"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        // 2. 匹配所有的 url 链接
        let results = regex.matches(in: textStorage.string, options: [], range: NSRange(location: 0, length: textStorage.length))
        
        var array = [NSRange]()
        
        for m in results {
            array.append(m.range(at: 0))
        }
        
        return array
    }
}
