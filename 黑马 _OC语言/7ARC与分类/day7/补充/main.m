//
//  main.m
//  补充
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
   
    Car * bm = [Car new];
    Person * p1 = [[Person alloc]initWithCar:bm];
    NSLog(@"bm = %lu",bm.retainCount);
    
    
    [p1 release];
    [bm release];
    return 0;
}
