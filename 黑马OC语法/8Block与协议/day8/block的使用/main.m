//
//  main.m
//  block的使用
//
//  Created by 翟佳阳 on 2021/8/17.
//

#import <Foundation/Foundation.h>

//void test(void(^block)(void))
//{
//    NSLog(@"11111111");
//    block();
//}
typedef void(^NewType)(void);
void test(NewType block1)
{
    NSLog(@"111111");
    block1();
}

void test2(int(^paramsBlock)(int num1,int num2))
{
    NSLog(@"222222222");
    int sum = paramsBlock(100,200);
    NSLog(@"sum = %d", sum);
    
}
int main(int argc, const char * argv[]) {
    NewType type = ^{
        NSLog(@"yeyeye");
    };
    test(type);//法1
    test(^{
        NSLog(@"yeyeye");
    });//法2
     
    test2(^int(int num1, int num2) {
        return num1 + num2;
    });
    
    return 0;
}
