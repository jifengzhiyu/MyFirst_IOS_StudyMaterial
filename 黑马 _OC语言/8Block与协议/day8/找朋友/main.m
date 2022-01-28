//
//  main.m
//  找朋友
//
//  Created by 翟佳阳 on 2021/8/19.
//
/*
 1、洗衣服
 2、做饭
 3、优先考虑：月薪过万
 
 蓝：
 属性：姓名，年龄，钱，绿友
 行为：爱
 
 绿协议：
 洗衣
 做饭
 */
#import <Foundation/Foundation.h>
# import "Boy.h"
#import "Gril.h"
#import <limits.h>
#import "Pig.h"
int main(int argc, const char * argv[]) {
    Boy * b1 = [Boy new];
    b1.name = @"jack";
    b1.age = 20;
    b1.money = INT32_MAX;
    
    Gril * fj = [Gril new];
    fj.name = @"凤姐";
    b1.grilFriend = fj;
    [b1 love];
    
    Pig * p1 = [Pig new];
    b1.grilFriend = p1;
    [b1 love];
    
    b1.grilFriend = b1;
    [b1 love];
    //自己可以作为自己的对象
    return 0;
}
