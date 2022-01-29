//
//  Person.m
//  构造方法
//
//  Created by 翟佳阳 on 2021/8/11.
//

#import "Person.h"

@implementation Person
- (void)sayHi{
    NSLog(@"你好呀");
}
- (instancetype)init{
    self = [super init];
    if(self != nil){
        //if(self = [super init])
        self.name = @"jack";
        self.dog = [Dog new];
        //创建person对象时dog属性就已经指向Dog
    }
    return self;
}
@end
