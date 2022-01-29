//
//  Person.m
//  属性的封装
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import "Person.h"

@implementation Person
- (void)sayHi{
    NSLog(@"我叫%@，我今年%d岁",_name,_age);
}
- (void)setAge:(int)age{
    if(age >= 0 && age <= 200){
        _age = age;
    }else{
        _age = 18;
    }
}
- (void)setName:(NSString*)name{
    //为姓名属性赋值的时候，要求姓名的长度不小于2，否则赋值@"无名"
    if([name length] < 2){
        _name = @"无名";
        return;
    }//判断传进来的名字是否符合要求
    _name = name;
}
- (int)age{
    return _age;
    
}
- (NSString*)name{
    return _name;
}
@end
