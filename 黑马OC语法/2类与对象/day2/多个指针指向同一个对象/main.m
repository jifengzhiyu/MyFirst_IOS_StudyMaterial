//
//  main.m
//  多个指针指向同一个对象
//
//  Created by 翟佳阳 on 2021/8/3.
//
#import <Foundation/Foundation.h>
@interface Person : NSObject
{
    @public
    NSString* _name;
    int _age;
}
@end

@implementation Person
- (void)sayHi{
    NSLog(@"我叫%@，今年%d岁",_name,_age);
}
@end


int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    p1->_name = @"小花";
    p1->_age = 19;
    Person* p2 = p1;
    p2->_name = @"小明";
    NSLog(@"%@",p1->_name);
    //p1,p2都指向同一个对象
    return 0;
}
