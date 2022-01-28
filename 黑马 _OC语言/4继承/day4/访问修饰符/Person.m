//
//  Person.m
//  访问修饰符
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Person.h"

@implementation Person
- (void)sayHi{
    _name = @"jack";
    _age = 20;
    NSLog(@"_name = %@",_name);
    NSLog(@"我是人");
}
- (void)setName:(NSString*)name{
    _name = name;
}
- (NSString*)name{
    return _name;
}
@end
