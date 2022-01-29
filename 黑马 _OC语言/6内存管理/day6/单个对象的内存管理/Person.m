//
//  Person.m
//  单个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import "Person.h"

@implementation Person
- (void)dealloc{
    NSLog(@"挂了");
    [super dealloc];
}
@end
