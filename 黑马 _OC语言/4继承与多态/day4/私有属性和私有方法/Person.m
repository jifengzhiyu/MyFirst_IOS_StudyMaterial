//
//  Person.m
//  私有属性和私有方法
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Person.h"

@implementation Person
{
    //@public
    NSString* _name;
    int _age;
}
- (void)sayHi{
    NSLog(@"你好呀");
}
- (void)hehe{
    [self sayHi];
}
@end
