//
//  JFWeibo.m
//  微博
//
//  Created by 翟佳阳 on 2021/9/15.
//

#import "JFWeibo.h"

@implementation JFWeibo
- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)weiboWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
