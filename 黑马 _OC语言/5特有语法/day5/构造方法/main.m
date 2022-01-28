//
//  main.m
//  构造方法
//
//  Created by 翟佳阳 on 2021/8/11.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"
int main(int argc, const char * argv[]) {
    Person* p1 = [Person alloc];
    Person* p2 = [p1 init];
    //等价于 Person* p1 = [[Person alloc] init];
    [p2.dog shout];
    Dog* d1 = [[Dog alloc]initWithName:@"大狗" andAge:132];
    return 0;
}
