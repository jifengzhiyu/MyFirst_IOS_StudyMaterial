//
//  main.m
//  对象与方法
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"

int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    Dog* d1 = [Dog new];
    [p1 test: d1];
    Dog* d2 = [p1 test1];
    return 0;
}
