//
//  Person.m
//  自定义类实现对象的拷贝
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import "Person.h"

@implementation Person
- (id)copyWithZone:(nullable NSZone *)zone{
    //如果深拷贝：重新创建一个对象，将当前对象属性的值，复制到新对象中，并将新对象返回
//    Person * p1 = [Person new];
//    p1.name = _name;
//    p1.age = _age;
//    return  p1;
    
    
    
    //深拷贝
    return  self;

}
@end
