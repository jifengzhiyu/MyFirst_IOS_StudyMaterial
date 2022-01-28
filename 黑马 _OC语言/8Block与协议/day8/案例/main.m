//
//  main.m
//  案例
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import <Foundation/Foundation.h>
#import "Arry.h"
int main(int argc, const char * argv[]) {
    Arry * arr = [Arry new];
    [arr bianLiWithBlock:^(int val) {
        NSLog(@"val = %d",val + 1);
    }];
    
    
    
    return 0;
}
