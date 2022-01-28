//
//  Student.m
//  super
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Student.h"

@implementation Student
- (void)study{
    NSLog(@"刻苦学习");
    [self sayHi];
    //等价于
    [super sayHi];
}
+(void)haha{
   //以下四个语句都等价
    [Person hehe];
    [Student hehe];
    [self hehe];
    [super hehe];
}
@end
