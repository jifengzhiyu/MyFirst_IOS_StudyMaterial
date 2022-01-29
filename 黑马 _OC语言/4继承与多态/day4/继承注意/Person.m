//
//  Person.m
//  继承注意
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Person.h"

@implementation Person
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

- (void)sayHiPerson{
    NSLog(@"person你好呀");
}
@end
