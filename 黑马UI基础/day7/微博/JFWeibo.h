//
//  JFWeibo.h
//  微博
//
//  Created by 翟佳阳 on 2021/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFWeibo : NSObject
@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *picture;
@property (nonatomic,copy)NSString *name;
@property(nonatomic,assign,getter = isVip)BOOL vip;
//getter = isVip,更改get方法的名称
- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)weiboWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
