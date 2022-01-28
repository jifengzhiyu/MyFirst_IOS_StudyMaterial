//
//  Person.m
//  MRC程序
//
//  Created by 翟佳阳 on 2021/8/11.
//

#import "Person.h"

@implementation Person
- (void)sayHi{
    NSLog(@"你好呀");
}
- (void)dealloc{
    NSLog(@"%@挂了",_name);
    [super dealloc];
}
@end
