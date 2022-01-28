//
//  main.m
//  block
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import <Foundation/Foundation.h>
int num1 = 10;

int main(int argc, const char * argv[]) {
//    void(^myBlock1)(void);
//    myBlock1 = ^void(){
//        NSLog(@"你好");
//    };
    void(^myBlock1)(void) = ^{
        NSLog(@"你好");
    };//无参数无返回值
    
    int(^myBlock2)(void) = ^int{
        int num1 = 10;
        return num1;
    };//有返回值无参数的代码段
    
    int(^myBlock3)(int,int) = ^(int num1,int num2){
        int num3 = num1 + num2;
        return  num3;
    };//有返回值有参数的代码段
    
    myBlock1();
    
    int sum = myBlock2();
    NSLog(@"sum = %d",sum);
    
    int res = myBlock3(10,32);
    NSLog(@"res = %d",res);
    
   
    typedef int (^NewType2)(int num1,int num2);
    NewType2 t1 = ^int(int num1,int num2){
        int num3 = num1 + num2;
        return  num3;
    };
    
    __block int num2 = 20;
    typedef void (^NewType)(void);
    NewType block1 = ^{
        int num3 = 30;
        num2++;
        num1++;
        NSLog(@"num = %d",num2);
    };
    
    block1();
    
    return 0;
}
