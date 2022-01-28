//
//  Teacher.m
//  继承
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Teacher.h"

@implementation Teacher
- (void)setName:(NSString*)name{
    _name = name;
}
- (NSString*)name{
    return _name;
}

- (void)setAge:(int)age{
    _age = age;
}
- (int)age{
    return _age;
}

- (void)setHeight:(float)height{
    _height = height;
}
- (float)height{
    return _height;
}

- (void)setWeight:(float)weight{
    _weight = weight;
}
- (float)weight{
    return _weight;
}
- (void)setSalary:(double)salary{
    _salary = salary;
}
- (double)salary{
    return _salary;
}
@end
