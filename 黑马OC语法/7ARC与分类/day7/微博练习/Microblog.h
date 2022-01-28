//
//  Microblog.h
//  微博练习
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "User.h"
NS_ASSUME_NONNULL_BEGIN
/*
 微博类（Microblog)
 属性：
 文字内容
 图片
 发表时间（NAAtring*)
 作者
 被转发的微博
 评论数
 转发数
 点赞数
 */
@interface Microblog : NSObject
@property(nonatomic,retain)NSString* content;
//微博配图路径，一般9张
@property(nonatomic,retain)NSString * imgURL;
@property(nonatomic,assign)KXDate *sendTime;
@property(nonatomic,retain)User *user;
@property(nonatomic,retain)Microblog * zhuanFaBlog;
@end

NS_ASSUME_NONNULL_END
