//
//  JFcar.h
//  汽车品牌
//
//  Created by 翟佳阳 on 2021/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFcar : NSObject
//组标题
@property(nonatomic,copy)NSString * title;
//组描述
@property(nonatomic,copy)NSString * desc;
//品牌信息
@property(nonatomic,strong)NSArray * cars;

//必须要封装的两个方法
-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)carWithDict:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
