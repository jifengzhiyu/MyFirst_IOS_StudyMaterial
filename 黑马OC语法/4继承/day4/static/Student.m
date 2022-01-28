//
//  Student.m
//  static
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import "Student.h"

@implementation Student
- (void)setNumber:(int)number{
    _number = number;
}
- (int)number{
    return _number;
}

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

+ (instancetype)student{
    return [Student new];
}
+ (instancetype)studentWithName:(NSString*)name andAge:(int)age{
    static int biaoHao = 1;
    Student* s1 = [Student new];
    s1->_name = name;
    s1->_age = age;
    s1->_number = biaoHao;
    biaoHao++;
    return s1;
}
 
@end
