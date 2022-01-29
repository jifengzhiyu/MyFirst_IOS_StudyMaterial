//
//  StatusViewModel.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/2.
//

import UIKit
/// 微博视图模型 - 处理单条微博的业务逻辑
class StatusViewModel: CustomStringConvertible{
    /// 微博的模型
    var status: Status

    /// 表格的可重用表示符号
    var cellId: String {
        return status.retweeted_status != nil ? StatusCellRetweetedId : StatusCellNormalId
    }
    
    /// 缓存的行高
    lazy var rowHeight: CGFloat = {
        print("计算行高 \(self.status.text ?? "")")
        
        // 1. cell
        // 定义 cell
        var cell: StatusCell
        
        // 根据是否是转发微博，决定 cell 的创建
        if self.status.retweeted_status != nil {
            cell = StatusRetweetedCell(style: .default, reuseIdentifier: StatusCellRetweetedId)
        } else {
            cell = StatudNormalCell(style: .default, reuseIdentifier: StatusCellNormalId)
        }
        
        // 2. 记录高度
        return cell.rowHeight(vm: self)
       
    }()
    
    /// 微博发布日期 － 计算型属性
    var createAt: String? {
        return NSDate.sinaDate(string: status.created_at ?? "")?.dateDescription
    }
    
    
    /// 用户头像 URL
    var userProfileUrl: URL {
        return URL(string: status.user?.profile_image_url ?? "")!
    }
    
    var retweetedText: String? {
        
        // 1. 判断是否是转发微博，如果不是直接返回 nil
        guard let s = status.retweeted_status else {
            return nil
        }
        
        // 2. s 就是转发微博
        return "@" + (s.user?.screen_name ?? "") + ":" + (s.text ?? "")
    }
    
    /// 用户默认头像
    var userDefaultIconView: UIImage {
        return UIImage(named: "avatar_default_big")!
    }
    
    /// 用户会员图标
    var userMemberImage: UIImage? {
        
        // 根据 mbrank 来生成图像
        if status.user!.mbrank > 0 && status.user!.mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(status.user!.mbrank)")
        }
        return nil
    }
    
    /// 用户认证图标
    /// 认证类型，-1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var userVipImage: UIImage? {
        
        switch(status.user?.verified_type ?? -1) {
        case 0: return UIImage(named: "avatar_vip")
        case 2, 3, 5: return UIImage(named: "avatar_enterprise_vip")
        case 220: return UIImage(named: "avatar_grassroot")
        default: return nil
        }
    }
    
    /// 缩略图URL数组 - 存储型属性 !!!
    /// /// 如果是原创微博，可以有图，可以没有图
    /// 如果是转发微博，一定没有图，retweeted_status 中，可以有图，也可以没有图
    /// 一条微博，最多只有一个 pic_urls 数组
    var thumbnailUrls: [URL]?
    
    /// 构造函数
    init(status: Status) {
        self.status = status
        
        if let urls = status.retweeted_status?.pic_urls ?? status.pic_urls{
        // 根据模型，来生成缩略图的数组
            
            // 创建缩略图数组
            thumbnailUrls = [URL]()
            
            // 遍历字典数组 -> 数组如果可选，不允许遍历，原因：数组是通过下标来检索数据
            for dict in urls {
                
                // 因为字典是按照 key 来取值，如果 key 错误，会返回 nil
                let url = URL(string: dict["thumbnail_pic"]!)
                
                // 相信服务器返回的 url 字符串一定能够生成
                thumbnailUrls?.append(url!)
            }
        }
    }
    
    /// 描述信息
    var description: String {
        //((thumbnailUrls ?? [] ) as NSArray)为了让打印数据好看
        return status.description + "配图数组 \((thumbnailUrls ?? [] ) as NSArray)"
//        return status.description
        
        
    }
}
