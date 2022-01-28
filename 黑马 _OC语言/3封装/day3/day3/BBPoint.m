//
//  BBPoint.m
//  day3
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import "BBPoint.h"
#import <math.h>
@implementation BBPoint
- (double)distanceWithOtherPoint: (BBPoint*)otherPoint{
    //1、拿到当前点的X，Y坐标
    //2、拿到传入点的X，Y坐标
    //3、直接用公式
    double res1 = (_x - otherPoint->_x) * (_x - otherPoint->_x);
    double res2 = (_y - otherPoint->_y) * (_y - otherPoint->_y);
    double res3 = res1 + res2;
    return sqrt(res3);
    
}
@end
