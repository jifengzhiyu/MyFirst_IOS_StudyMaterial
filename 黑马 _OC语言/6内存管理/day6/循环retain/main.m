//
//  main.m
//  循环retain
//
//  Created by 翟佳阳 on 2021/8/13.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    Book* b1 = [Book new];
    
    p1.book = b1;
    b1.owner = p1;
    [p1 read];
    [b1 release];
    
    [p1 release];
    return 0;
}
