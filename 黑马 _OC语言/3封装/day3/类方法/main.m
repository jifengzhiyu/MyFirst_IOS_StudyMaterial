//
//  main.m
//  类方法
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
  
    [Person hehe];
    
    Person* p1 = [Person new];
    //等价于
    Person* p2 = [Person person];
    Person* p3 = [Person personWithName:@"小华" andAge:79];
    return 0;
}
