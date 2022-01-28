//
//  Province.m
//  02省市选择
//
//  Created by 翟佳阳 on 2021/9/25.
//

#import "Province.h"

@implementation Province
- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)provinceWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
