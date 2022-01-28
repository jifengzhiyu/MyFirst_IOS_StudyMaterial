//
//  ITCASTProduct.m
//  06网易彩票
//
//  Created by teacher on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTProduct.h"

@implementation ITCASTProduct


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
        self.url = dict[@"url"];
        self.ID = dict[@"id"];
        self.customUrl = dict[@"customUrl"];
    }
    return self;
}

+ (instancetype)productWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
