//
//  Account.h
//  微博练习
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 账户类
 
 名称
 密码
 注册时间（NSString*)
 */

typedef struct
{
    int year;
    int month;
    int day;
}KXDate;
@interface Account : NSObject
@property(nonatomic,strong)NSString* userName;
@property(nonatomic,strong)NSString* password;
//账户注册时间
@property(nonatomic,assign)KXDate registDate;

@end

NS_ASSUME_NONNULL_END
