//
//  main.m
//  野指针与僵尸对象
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    [p1 release];
    //对象已经被回收，p1现在是野指针
    p1 = nil;
    [p1 sayHi];
    p1.age = 10;
    //p1-> name = @"jack";
    return 0;
}
