//
//  Person.m
//  ARC机制下的循环引用
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import "Person.h"

@implementation Person
- (void)dealloc{
    NSLog(@"人死了");
}
@end
