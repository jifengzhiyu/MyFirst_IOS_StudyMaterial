//
//  main.m
//  类对象的使用
//
//  Created by 翟佳阳 on 2021/8/8.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Class c1 = [Person class];
    //typedef struct objc_class *Class;
    //定义typedef的时候加*，声明类对象指针就不加*
    
    Person* p0 = [c1 new];
    NSLog(@"c1 = %p",c1);
    
    Person* p1 = [Person new];
    Class c2 = [p1 class];
    NSLog(@"c2 = %p",c2);
    
    [c1 sayHi];
    return 0;
}
 
