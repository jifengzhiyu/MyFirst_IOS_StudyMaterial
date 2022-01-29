//
//  Status.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/2.
//

import UIKit
/// 微博数据模型
class Status: NSObject {
    /// 微博ID
    @objc var id: Int = 0
    /// 微博信息内容
    @objc var text: String?
    /// 微博创建时间
    @objc var created_at: String?
    /// 微博来源
    ///  /// 缩略图配图数组 key: thumbnail_pic
    var pic_urls: [[String: String]]?
    @objc var source: String?{
        didSet {
            // 过滤出文本，并且重新设置 source
            // 注意：在 didSet 内部重新给属性设置数值，不会再次调用 didSet
            source = source?.href()?.text
        }
    }
//    /// 用户模型
    var user: User?
    /// 被转发的原微博信息字段
    var retweeted_status: Status?
    
    init(dict: [String: Any]) {
        super.init()
        
        // 如果使用 KVC 时，value 是一个字典，会直接给属性转换成字典
        setValuesForKeys(dict)
    }
    
    //setValuesForKeys(dict) 多次调用下面
    override func setValue(_ value: Any?, forKey key: String) {
        
        // 判断 key 是否是 user
        if key == "user" {
            if let dict = value as? [String: AnyObject] {
                
                user = User(dict: dict)
            }
            //⚠️
            return 
        }
        
        // 判断 key 是否是 retweeted_status
        if key == "retweeted_status" {
            if let dict = value as? [String: AnyObject] {
                retweeted_status = Status(dict: dict)
            }
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["id", "text", "created_at", "source", "user", "pic_urls", "retweeted_status"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
