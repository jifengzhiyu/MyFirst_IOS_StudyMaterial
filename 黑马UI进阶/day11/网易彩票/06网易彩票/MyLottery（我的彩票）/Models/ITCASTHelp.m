//
//  ITCASTHelp.m
//  06网易彩票
//
//  Created by teacher on 15/7/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTHelp.h"

@implementation ITCASTHelp
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.ID = dict[@"id"];
        self.html = dict[@"html"];
    }
    return self;
}

+ (instancetype)helpWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
