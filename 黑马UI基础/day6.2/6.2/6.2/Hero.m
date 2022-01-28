//
//  Hero.m
//  6.2
//
//  Created by 翟佳阳 on 2021/9/12.
//

#import "Hero.h"

@implementation Hero
-(instancetype)initWithDict:(NSDictionary*)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)heroWithDict:(NSDictionary*)dict{
    return [[self alloc]initWithDict:dict];
}
@end
