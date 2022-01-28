//
//  main.m
//  @property增强
//
//  Created by 翟佳阳 on 2021/8/9.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Pig.h"
int main(int argc, const char * argv[]) {
    Student* s1 = [Student new];
    [s1 setName:@"jack"];
    s1.name = @"helen";
    Pig * p1 = [Pig new];
    [p1 test];
    return 0;
}
