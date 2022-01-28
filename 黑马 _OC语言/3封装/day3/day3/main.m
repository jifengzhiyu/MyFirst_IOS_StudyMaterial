//
//  main.m
//  day3
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "BBPoint.h"
int main(int argc, const char * argv[]) {
//    Person* p1 = [Person new];
//    p1->_name = @"小明";
//
//    Dog* wangCai = [Dog new];
//    wangCai->_name = @"旺财";
//    wangCai->_color = @"黄色";
//    wangCai->_age = 4;
//
//    Dog* daHuang = [Dog new];
//    daHuang->_age = 3;
//
//    BOOL res = [wangCai compareAgeWithOtherDog:daHuang];
//    NSLog(@"res = %d",res);
    
    BBPoint* p1 = [BBPoint new];
    p1->_x = 100;
    p1->_y = 90;
    
    BBPoint* p2 = [BBPoint new];
    p2->_x = 200;
    p2->_y = 20;
    
    double dis = [p1 distanceWithOtherPoint:p2];
    NSLog(@"dis = %lf",dis);
    
    return 0;
}
