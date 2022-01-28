//
//  main.m
//  类与对象
//
//  Created by 翟佳阳 on 2021/8/1.
//

/*
 1、
 
 2、
 
 3、
 
 4、
 5、
 
 6、
 
 7、
 8、
 
 9、
 
 
    
 */


#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    @public
    NSString* _name;
    int _age;
    float _height;
}
@end


@implementation Person
@end

int main(int argc, const char * argv[]) {
    Person *p1 = [Person new];
    p1->_name = @"jack";
    p1->_age = 10;
    p1->_height = 153.8f;
    
    //也可以这样给属性赋值
    //对象的本质是结构体
    //(*p1)._name = @"jack";
    (*p1)._age = 10;
    (*p1)._height = 153.8f;
    
    NSLog(@"p1对象的_name属性的值是%@",p1->_name);
    NSLog(@"p1对象的_age属性的值是%d",p1->_age);
    return 0;
}
