//
//  main.m
//  静态类型和动态类型
//
//  Created by 翟佳阳 on 2021/8/9.
//

#import <Foundation/Foundation.h>
#import "Pig.h"
int main(int argc, const char * argv[]) {
    Animal* a1 = [Pig new];
    [(Pig*) a1 eat];//强制类型转换，骗过编译器
    return 0;
}
