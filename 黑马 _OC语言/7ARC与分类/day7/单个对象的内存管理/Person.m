//
//  Person.m
//  单个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import "Person.h"

@implementation Person
- (void)dealloc
{
    NSLog(@"人死了");
}

- (void)sayHi{
    NSLog(@"你好呀");
}
@end
