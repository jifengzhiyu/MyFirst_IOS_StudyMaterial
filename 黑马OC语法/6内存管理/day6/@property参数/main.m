//
//  main.m
//  @property参数
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    Car *bm = [Car new];
    
    p1.car = bm;
    [p1 drive];
    
//    Car * benc = [Car new];
//    p1.car = benc;
//
//
//    [benc release];
    p1.car = bm;
    
//    [p1 xyz:20];
    p1.age = 30;
    int age = [p1 xxx];
    NSLog(@"age = %d",age);
    
    p1.goodPerson = YES;
    BOOL flag = p1.isGoodPerson;
    NSLog(@"good = %d",flag);
    
    [bm release];
    [p1 release];
    
    return 0;
}
