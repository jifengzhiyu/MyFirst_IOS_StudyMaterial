//
//  self.m
//  self
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import "self.h"

@implementation self
- (void)sayHi{
//    NSString* _name= @"jack";
//    NSLog(@"%@",_name);
    NSLog(@"我是%@，今年%d岁",_name,_age);
    //等价
    NSLog(@"我是%@，今年%d岁",self->_name,self->_age);
    
    NSLog(@"self = %p",self);
    
}
- (void)hehe{
    //调用当前对象的sayHi方法
    //self* p1 = [self new];
    //[p1 sayHi];创建一个新的对象，不是该对象
    [self sayHi];
    
}

+ (void)sb{
    NSLog(@"self = %p",self);
}

+(void)dsd{
    [self sb];
    //self关键词 等价于类名self
}
@end
