//
//  Person.m
//  内存分析工具
//
//  Created by 翟佳阳 on 2022/1/1.
//

#import "Person.h"

@implementation Person
- (void)dealloc
{
    NSLog(@"人死了, 钱没花了");
}
@end
