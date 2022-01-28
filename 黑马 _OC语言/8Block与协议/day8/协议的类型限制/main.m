//
//  main.m
//  协议的类型限制
//
//  Created by 翟佳阳 on 2021/8/19.
//

#import <Foundation/Foundation.h>
#import "StudtyProtocol.h"
#import "Student.h"
#import "AbaProtocol.h"
#import "AbaStudent.h"
//声明一个指针，该指针可以指向任意的对象，指向的对象要 遵守指定的协议
//不遵守，警告
int main(int argc, const char * argv[]) {
    NSObject <StudtyProtocol> *obj = [Student new];
    id <StudtyProtocol> id1 = [Student new];
    
    NSObject<StudtyProtocol,AbaProtocol> * obj2 = [Student new];
    id <StudtyProtocol,AbaProtocol> obj3 = [Student new];

    Student<StudtyProtocol> *stu = [AbaStudent new];
    return 0;
}
