//
//  main.m
//  多个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/12.
//
/*
 凤姐开车去拉萨
 
 人类：
 属性：车
 行为：开车
 
 车类：
 属性：速度
 行为：行驶
 */
#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person *fj = [Person new];
    Car * bm = [Car new];
    
    bm.speed = 100;
    fj.car = bm;
    
    Car *benZhi = [Car new];
    benZhi.speed = 200;
    fj.car = benZhi;
    
    
    [benZhi release];
    [bm release];
    [fj release]; 
    return 0;
}
