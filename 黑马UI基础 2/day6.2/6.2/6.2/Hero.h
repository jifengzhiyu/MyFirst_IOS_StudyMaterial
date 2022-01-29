//
//  Hero.h
//  6.2
//
//  Created by 翟佳阳 on 2021/9/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hero : NSObject
@property(nonatomic,copy)NSString * icom;
@property(nonatomic,copy)NSString * intro;
@property(nonatomic,copy)NSString * name;

-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)heroWithDict:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
