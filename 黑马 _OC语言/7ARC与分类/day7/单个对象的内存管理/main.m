//
//  main.m
//  单个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Person * p1 = [Person new];
//        Person * p2 = p1;
        
        
        
//        Person * p1 = [Person new];
//        p1 = nil;
        
        Person * p1 = [Person new];
        __weak Person * p2 = p1;
        p1 = nil;
        [p2 sayHi];
        
        
    }
    return 0;
}
