//
//  JFFriend.m
//  2好友列表
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import "JFFriend.h"

@implementation JFFriend
- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)friendWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
