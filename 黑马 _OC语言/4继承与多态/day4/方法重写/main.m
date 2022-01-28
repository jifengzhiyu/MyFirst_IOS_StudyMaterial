//
//  main.m
//  方法重写
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "Chinese.h"
int main(int argc, const char * argv[]) {
    Chinese* ch = [Chinese new];
    [ch sayHi];
    Person* p0 = [Person new];
    [p0 sayHi];
    Person* p1 = [Chinese new];
    [p1 sayHi];
    return 0;
}
