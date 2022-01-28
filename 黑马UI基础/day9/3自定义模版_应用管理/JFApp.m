//
//  JFApp.m
//  3自定义模版_应用管理
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import "JFApp.h"

@implementation JFApp
- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)AppWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
