//
//  main.m
//  属性的封装
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
int main(int argc, const char * argv[]) {
    Person * p1 = [Person new];
    
    //想要限制年龄，给属性赋值做一个逻辑验证（判断是不是在逻辑值之内）
    //判断年龄是不是在0-200之间，否则就以默认值处理
    [p1 setAge:900];
    NSLog(@"p1对象_age的值是%d",[p1 age]);
    [p1 setName:@"小花花"];
    NSLog(@"%@",[p1 name]);
    
    Student* s1 = [Student new];
    [s1 setName:@"毛泽东"];
    [s1 setAge:12];
    [s1 setYuWen:120];
    [s1 setShuXue:22];
    [s1 setYingYu:120];
    [s1 show];
    return 0;
}
