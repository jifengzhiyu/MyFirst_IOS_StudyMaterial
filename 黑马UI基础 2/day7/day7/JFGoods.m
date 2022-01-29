//
//  JFGoods.m
//  day7
//
//  Created by 翟佳阳 on 2021/9/14.
//

#import "JFGoods.h"

@implementation JFGoods
- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)goodsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
