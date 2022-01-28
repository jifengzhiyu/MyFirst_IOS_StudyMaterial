//
//  main.m
//  self
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "self.h"
int main(int argc, const char * argv[]) {
    self* p1 = [self new];
    p1->_name = @"小米";
    p1->_age = 10;
    [p1 sayHi];
    [p1 hehe];
    NSLog(@"p1 = %p",p1);
    
    [self sb];
    NSLog(@"class = %p",[p1 class]);
    NSLog(@"class = %p",[self class]);
    return 0;
}
