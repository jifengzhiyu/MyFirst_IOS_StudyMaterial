//
//  Person.m
//  strong&weak
//
//  Created by 翟佳阳 on 2021/10/19.
//

#import "Person.h"
//mrc
@implementation Person
+ (instancetype)personWithName:(NSString *)name{
    //延迟释放：把对象放到自动释放池
    Person *person = [[Person new] autorelease];
    person.name = name;
    return person;
}

@end
