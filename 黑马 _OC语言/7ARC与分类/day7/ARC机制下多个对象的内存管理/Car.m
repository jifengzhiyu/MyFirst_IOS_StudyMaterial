//
//  Car.m
//  ARC机制下多个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import "Car.h"

@implementation Car
- (void)run{
    NSLog(@"时速为%d的车正在跑"，_speed)；
}
- (void)dealloc{
    BSLog(@"车废了");
}
@end
