//
//  Person.m
//  单例模式
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import "Person.h"

@implementation Person
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static id instance = nil;
    //static修饰的局部变量：生存期为整个源程序，只能在定义该变量的函数内使用。退出该函数后， 尽管该变量还继续存在，
    //但不能使用它
    if(instance == nil)
    {
        instance = [super allocWithZone:zone];
    }
    return  instance;
//    NSLog(@"asasassas");
//    return  nil;
}
+(instancetype)sharedPerson
{
    return [self new];
}
+(instancetype)defaultPerson
{
    return [self new];
}

@end
