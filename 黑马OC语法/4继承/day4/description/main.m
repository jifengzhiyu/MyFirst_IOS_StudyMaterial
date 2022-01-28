//
//  main.m
//  description
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    NSLog(@"p1 = %p",p1);
    NSLog(@"p1 = %@",p1);
    NSString* str = [p1 description];
    NSLog(@"%@",str);
    return 0;
}
