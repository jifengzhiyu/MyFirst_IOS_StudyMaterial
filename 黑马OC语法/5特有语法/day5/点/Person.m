//
//  Person.m
//  点
//
//  Created by 翟佳阳 on 2021/8/8.
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
    NSLog(@"setAge");
}
- (int)age{
    NSLog(@"getAge");
    return _age;
    
}
@end
