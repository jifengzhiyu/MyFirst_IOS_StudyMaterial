//
//  main.m
//  ARC
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    
        __strong Person * p1 = [Person new];
        //等价于 Person * p1;
        
        __weak Person * p2 = p1;
    //p1 = nil;
        
        [p1 sayHi];
        [p2 sayHi];
        
    
    return 0;
}
