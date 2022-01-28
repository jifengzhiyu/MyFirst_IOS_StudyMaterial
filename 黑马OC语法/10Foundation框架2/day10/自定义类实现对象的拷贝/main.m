//
//  main.m
//  自定义类实现对象的拷贝
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    
    Person * p1 = [Person new];
    Person<NSCopying> * p2 = [p1 copy];
    NSLog(@"p1 = %p",p1);
    NSLog(@"p2 = %p",p2);
    
    return 0;
}
