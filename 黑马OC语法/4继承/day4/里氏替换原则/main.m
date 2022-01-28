//
//  main.m
//  里氏替换原则
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "Student.h"
int main(int argc, const char * argv[]) {
    Person* p2 = [Student new];
    [p2 setName:@"jack"];
    NSObject* obj = [Student new];
    
    Person* ps[2];
    ps[0] = [Person new];
    ps[1] = [Student new];
    
    NSObject* objs[2];
    objs[0] = [Person new];
    objs[1] = [Student new];
    
    
    return 0;
}
