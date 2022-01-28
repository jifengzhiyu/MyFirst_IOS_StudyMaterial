//
//  Person.m
//  @property参数
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import "Person.h"

@implementation Person
- (void)dealloc{
    NSLog(@"人挂了");
    [_car release];
    [super dealloc];
}
- (void)drive{
    NSLog(@"开车");
    [_car run];
}
@end
