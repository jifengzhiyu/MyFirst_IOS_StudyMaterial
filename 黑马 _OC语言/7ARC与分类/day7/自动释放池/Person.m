//
//  Person.m
//  自动释放池
//
//  Created by 翟佳阳 on 2021/8/13.
//

#import "Person.h"

@implementation Person
- (void)dealloc
{
    NSLog(@"人挂了");
    [_name release];
    [super dealloc];
}
@end
