//
//  main.m
//  点
//
//  Created by 翟佳阳 on 2021/8/8.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    p1.name = @"jack";
    p1.age = 19;
    
    NSString* name = p1.name;
    NSLog(@"name = %@",name);
    return 0;
}
