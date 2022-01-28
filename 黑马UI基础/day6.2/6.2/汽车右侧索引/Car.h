//
//  Car.h
//  汽车右侧索引
//
//  Created by 翟佳阳 on 2021/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *name;
-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)carWithDict:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
