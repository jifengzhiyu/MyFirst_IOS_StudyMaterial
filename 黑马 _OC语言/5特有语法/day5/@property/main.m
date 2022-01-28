//
//  main.m
//  @property
//
//  Created by 翟佳阳 on 2021/8/9.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person *p1 = [Person new];
    p1.name = @"jack";
    NSLog(@"p1.name = %@",p1.name);
    p1.age = 10;
    NSLog(@"age = %d",p1.age);
    return 0;
}
