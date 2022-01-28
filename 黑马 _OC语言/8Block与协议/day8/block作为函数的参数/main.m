//
//  main.m
//  block作为函数的参数
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import <Foundation/Foundation.h>
typedef void (^NewType)(void);
NewType test(void)
{
    void(^block)(void) = ^{
        NSLog(@"1111111");
    };
    return block;
}

int main(int argc, const char * argv[]) {
    NewType type = test();
    type();
    return 0;
}
