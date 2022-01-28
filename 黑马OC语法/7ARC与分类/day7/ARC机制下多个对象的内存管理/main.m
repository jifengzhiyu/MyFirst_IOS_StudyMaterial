//
//  main.m
//  ARC机制下多个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person * p1 = [Person new];
    Car * c1 = [Car new];
    p1.car = c1;
    c1 = nil;
    return 0;
}
