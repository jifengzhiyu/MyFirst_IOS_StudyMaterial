//
//  main.m
//  多文件开发
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>
#import"Person.h"
#import "Dog.h"
int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    [p1 sayHi];
    Dog* d1 = [Dog new];
    [d1 sayHi];
    return 0;
}
