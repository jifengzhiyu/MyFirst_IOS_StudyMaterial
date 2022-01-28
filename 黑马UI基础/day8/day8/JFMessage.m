//
//  JFMessage.m
//  day8
//
//  Created by 翟佳阳 on 2021/9/16.
//

#import "JFMessage.h"

@implementation JFMessage
- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)messageWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
