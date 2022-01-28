//
//  Person.m
//  对象与方法
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import "Person.h"
#import "Dog.h"
@implementation Person
- (void)sayHi{
    NSLog(@"你好呀，我是人");
}
- (void)test:(Dog*)dog{
    [dog shout];
}
- (Dog*)test1{
    Dog* wangCai = [Dog new];
    wangCai->_name = @"旺财";
    wangCai->_color = @"黄";
    return wangCai;
}

@end
