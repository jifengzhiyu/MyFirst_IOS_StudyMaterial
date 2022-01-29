//
//  Emoticon.swift
//  表情键盘
//
//  Created by 翟佳阳 on 2021/12/9.
//

import UIKit

class Emoticon: NSObject {
    /// 发送给服务器的表情字符串
    @objc var chs: String?
    /// 在本地显示的图片名称 + 表情包路径
    @objc var png: String?
    /// emoji 的字符串
    var emoji: String?
    /// emoji 的字符串编码
    @objc var code: String? {
        didSet {
            emoji = code?.emoji
        }
    }
    /// 完整的路径
    @objc var imagePath: String {
        
        // 判断是否有图片
        if png == nil {
            return ""
        }
        
        // 拼接完整路径
        return Bundle.main.bundlePath + "/Emoticons.bundle/" + png!
    }
    /// 是否删除按钮标记
    @objc var isRemoved = false
    /// 是否空白按钮标记
    @objc var isEmpty = false
    /// 表情使用次数
    @objc var times = 0
    
    // MARK: - 构造函数
    init(dict: [String: AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    init(isRemoved: Bool) {
        self.isRemoved = isRemoved
    }
    init(isEmpty: Bool) {
        self.isEmpty = isEmpty
    }
    
    
    
    override var description: String {
        let keys = ["chs", "png", "code","isRemoved","times"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
