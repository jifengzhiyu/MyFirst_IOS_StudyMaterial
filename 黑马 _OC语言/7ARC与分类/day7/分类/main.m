//
//  main.m
//  分类
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Student+jifeng.h"
#import "Student+abaaba.h"
int main(int argc, const char * argv[]) {
    NSLog(@"asasdas");
    Student * s1 = [Student new];
    [s1 haha];
    [s1 hehe];
    [s1 setAge:10];
    s1.name = @"jack";
    
    
    [s1 sayHi];
    return 0;
}
