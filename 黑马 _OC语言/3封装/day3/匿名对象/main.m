//
//  main.m
//  匿名对象
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "God.h"

int test(){
    return 9;
}
int main(int argc, const char * argv[]) {
    [Person new]->_name = @"jack";
    //访问匿名对象的属性
    [[Person new] sayHi];
    //调用匿名对象的方法
    
    int num1 = 20;
    int num2 = num1 + test();
    
    God* ys = [God new];
    [ys killWithPerson:[Person new]];
    return 0;
}
