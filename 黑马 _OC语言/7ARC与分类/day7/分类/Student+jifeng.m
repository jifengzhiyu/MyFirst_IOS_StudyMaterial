//
//  Student+jifeng.m
//  分类
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import "Student+jifeng.h"

@implementation Student (jifeng)
- (void)haha{
    NSLog(@"haha");
}
-(int)age{
    return _age;
//    _name = @"jack";
    //无法访问真私有属性
}
- (void)setAge:(int)age{
    _age = age;
    //_name = @"helen";
    //[self setName:@"ao"];
}
-(void)sayHi
{
    NSLog(@"我是分类的jifeng的sayhi");
}
@end
