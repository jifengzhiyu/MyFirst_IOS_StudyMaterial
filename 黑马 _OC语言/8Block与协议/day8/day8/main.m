//
//  main.m
//  day8
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import <Foundation/Foundation.h>
int num = 10;
typedef void (^NewType)(void);
int main(int argc, const char * argv[]) {
    int num = 20;
   
    NewType block1 = ^{
        int num = 30;
        NSLog(@"num = %d",num);
    };
    block1();
    NSLog(@"aaaaa");
    return 0;
}
