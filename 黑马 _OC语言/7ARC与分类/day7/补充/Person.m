//
//  Person.m
//  补充
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import "Person.h"

@implementation Person
- (void)dealloc
{
    NSLog(@"人死了");
    [_car release];
    [super dealloc];
}
-(instancetype)initWithCar:(Car*)car
{
    if (self = [super init])
    {
        //_car = car;
        //- MRC模式下，方法内如果需要访问对象（其他对象作为属性），使用点语法
          //如果直接访问的话，不经过getter，setter，就不会经过@property retain参数带来的计数器增减
        self.car = car;
    }
    return self;
}

@end
