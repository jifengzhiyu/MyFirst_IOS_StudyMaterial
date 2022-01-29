//
//  UserAccount.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/29.
//

import UIKit

class UserAccount: NSObject {
    /// 用于调用access_token，接口获取授权后的access token
    var access_token: String?
    
    /// access_token的生命周期，单位是秒数
    ///     /// 一旦从服务器获得过期的时间，立刻计算准确的日期

    var expires_in: TimeInterval = 0{
        didSet{
            // 计算过期日期
expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    
    
    /// 过期日期
    var expiresDate: NSDate?
    
    /// 当前授权用户的UID
    var uid: String?
    
    /// 用户昵称
    var screen_name: String?
    /// 用户头像地址（大图），180×180像素
    var avatar_large: String?
    
    init(dict:[String : Any]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override class func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        let keys = ["access_token", "expires_in","uid","expiresDate","screen_name","avatar_large"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
