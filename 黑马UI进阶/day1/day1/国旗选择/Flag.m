//
//  Flag.m
//  国旗选择
//
//  Created by 翟佳阳 on 2021/9/26.
//

#import "Flag.h"

@implementation Flag

+ (instancetype)flagWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
