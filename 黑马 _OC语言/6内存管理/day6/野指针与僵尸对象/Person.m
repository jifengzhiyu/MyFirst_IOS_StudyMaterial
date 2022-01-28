//
//  Person.m
//  野指针与僵尸对象
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import "Person.h"

@implementation Person
- (void)dealloc{
    NSLog(@"挂了");
    [super dealloc];
}
- (void)sayHi{
    NSLog(@"你好");
}
@end
