//
//  JFFriend.h
//  2好友列表
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFFriend : NSObject
@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, assign, getter = isVip)BOOL vip;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
