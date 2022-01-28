//
//  Person.m
//  day3
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import "Person1.h"

@implementation Person1
- (void)LiuWithDog:(Dog*)dog
{
    NSLog(@"狗狗，我们散步去!");
    [dog shout];
    [Person hehe];
    //在对象方法中可以直接调用类方法
}
+ (void)hehe{
    NSLog(@"heehhehehhe");
    Person1* p1  = [Person1 new];
    p1->_name = @"jack";
    //如果在类方法的实现中创建一个对象，访问该对象的属性可以
}
+(Person1*)person{
    Person1* p1 = [Person1 new];
    return p1;
}
+(Person1*)personWithName:(NSString*)name andAge:(int)age{
    Person1* p1 = [Person1 new];
    p1->_name = name;
    p1->_age = age;
    return p1;
}
@end
