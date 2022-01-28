//
//  APP.h
//  day3
//
//  Created by 翟佳阳 on 2021/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APP : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * icon;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)appWithDict:(NSDictionary *)dict;

//不论ARC还是MRC模式，如果属性的类型是NSString，@property使用copy参数把传进来的字符串copy一份再赋值
//NSString----->copy:没有产生新的对象，将对象的地址返回 浅拷贝
@end

NS_ASSUME_NONNULL_END
