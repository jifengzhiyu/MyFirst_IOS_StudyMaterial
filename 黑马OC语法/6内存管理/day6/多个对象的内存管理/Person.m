//
//  Person.m
//  多个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import "Person.h"

@implementation Person
- (void)setCar:(Car*)car{
    
    //将传入车的对象赋值给当前_car属性
    //代表：传入的对象多了一个人使用
    //应该给该对象发送一条retain消息
    if(_car != car){
        [_car release];
        _car = [car retain];
    }
    //执行该方法可能之前已经被使用了
    //_car属性原本指向的对象少一个人使用
    //传入的对象多一个人使用
    
   
}
- (Car*)car{
    return _car;
}
- (void)drive{
    NSLog(@"开车");
}
- (void)dealloc{
    //当人对象挂了的时候，就不会使用_car指向的对象
    //不使用车对象，就release
    [_car release];
    NSLog(@"人挂了");
    [super dealloc];
}
@end
