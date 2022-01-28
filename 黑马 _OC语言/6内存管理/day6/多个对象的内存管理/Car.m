//
//  Car.m
//  多个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import "Car.h"

@implementation Car
- (void)setSpeed:(int)speed{
    _speed = speed;
}
- (int)speed{
    return _speed;
}
- (void)run{
    NSLog(@"以时速%d行驶",_speed);
}
- (void)dealloc{
    NSLog(@"车子报废了");
    [super dealloc];
}
@end
