//
//  main.m
//  单个对象的内存管理
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person * p1 = [Person new];//若下一句不执行，就会有内存泄漏
    [p1 release];
    return 0;
}
