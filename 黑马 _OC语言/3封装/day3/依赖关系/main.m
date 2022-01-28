//
//  main.m
//  依赖关系
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Phone* iPhone = [Phone new];
    Person* p1 = [Person new];
    [p1 callWithPhone:iPhone];
    return 0;
}
