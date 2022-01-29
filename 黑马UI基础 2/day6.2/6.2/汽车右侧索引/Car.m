//
//  Car.m
//  汽车右侧索引
//
//  Created by 翟佳阳 on 2021/9/13.
//

#import "Car.h"

@implementation Car
-(instancetype)initWithDict:(NSDictionary*)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)carWithDict:(NSDictionary*)dict{
    return [[self alloc] initWithDict:dict];
}

@end
