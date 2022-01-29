//
//  main.m
//  延展
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import <Foundation/Foundation.h>
#import "Person+jifeng.h"
#import "Student.h"
int main(int argc, const char * argv[]) {
    Person * p1 = [Person new];
    [p1 sayHi];
    [p1 run];
    [p1 sleep];
    p1.weight = 10.2;
    NSLog(@"weght = %f",p1.weight);
    
    Student * s1 = [Student new];
    
    return 0;
}
