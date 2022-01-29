//
//  main.m
//  MRC程序
//
//  Created by 翟佳阳 on 2021/8/11.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main() {
    Person * p1 = [[Person alloc]init];
    p1.name = @"阿阿";
    NSUInteger count = [p1 retainCount];
    NSLog(@"count = %lu",count);
    //[p1 release];
    [p1 retain];
    NSLog(@"count = %lu",p1.retainCount);
    return 0;
}
