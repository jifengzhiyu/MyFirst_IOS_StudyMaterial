//
//  main.m
//  protocol协议
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
int main(int argc, const char * argv[]) {
    Dog * d1 = [Dog new];
    [d1 run];
    [d1 sleep];
//    [d1 eat];
    return 0;
}
