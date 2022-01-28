//
//  Person.m
//  NSMumber
//
//  Created by 翟佳阳 on 2021/8/22.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithIntValue:(int)value
{
    if(self = [super init])
    {
        self.intValue = value;
    }
    return self;
}
+ (instancetype)numberWithIntValue:(int)value
{
    return [[self alloc]initWithIntValue:value];
}
@end
