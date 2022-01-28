//
//  User.h
//  微博练习
//
//  Created by 翟佳阳 on 2021/8/15.
//
/*
 作者类(User)
 名称
 生日
 找好
 */
#import <Foundation/Foundation.h>
#import "Account.h"
NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property(nonatomic,retain)NSString *nickName;
@property(nonatomic,assign)KXDate brithday;
@property(nonatomic,retain)Account *account;
@end

NS_ASSUME_NONNULL_END
