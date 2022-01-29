//
//  Group.h
//  汽车右侧索引
//
//  Created by 翟佳阳 on 2021/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Group : NSObject
@property (nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray * cars;

-(instancetype)initWithDict:(NSDictionary*)dict;
//Car里面也有同样一个名字的方法，但是在.m调用不影响
+(instancetype)groupWithDict:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
