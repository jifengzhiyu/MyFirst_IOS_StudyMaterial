//
//  Person.m
//  循环retain
//
//  Created by 翟佳阳 on 2021/8/13.
//

#import "Person.h"

@implementation Person
- (void)read{
    [_book castZhiShi];
    NSLog(@"书真好");
}
- (void)dealloc{
    NSLog(@"人挂了");
    [_name release];
    //[_book release]; 
    [super dealloc];
}
@end
