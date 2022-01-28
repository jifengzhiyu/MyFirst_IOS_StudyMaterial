//
//  main.m
//  ARC机制下的循环引用
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person * p1 = [Person new];
    Book * b1 = [Book new];
    p1.book = b1;
    b1.owner = p1;
    return 0;
}
