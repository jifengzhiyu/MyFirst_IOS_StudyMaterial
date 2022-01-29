//
//  APP.m
//  day3
//
//  Created by 翟佳阳 on 2021/9/3.
//

#import "APP.h"

@implementation APP

/// 对象方法，初始化并赋值初始数据
/// @param dict for in下来的每一个字典数组
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
    }
    return self;
}
+(instancetype)appWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}//类方法，创建对象

@end
