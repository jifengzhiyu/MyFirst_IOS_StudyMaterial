//
//  Person.m
//  作业
//
//  Created by 翟佳阳 on 2021/8/7.
//

#import "Person.h"


@implementation Person
- (void)setName:(NSString*)name{
    _name = name;
}
- (NSString*)name{
    return _name;
}

- (void)setGender:(Gender)gender{
    _gender = gender;
}
- (Gender)gender{
    return _gender;
}

- (void)setAge:(int)age{
    _age = age;
}
- (int)age{
    return _age;
}

@end
