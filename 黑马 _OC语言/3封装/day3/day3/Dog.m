//
//  Dog.m
//  day3
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import "Dog.h"

@implementation Dog
- (void)shout{
    NSLog(@"汪汪汪");
}
- (BOOL)compareAgeWithOtherDog:(Dog*)otherDog{
    //1、拿到当前狗的年龄
   
    //2、拿到传入狗的年龄
    
    //3、比较
    
    return _age > otherDog->_age;
}
@end
