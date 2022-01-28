//
//  Person.m
//  copy
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import "Person.h"

@implementation Person
- (void)setName:(NSString*) name{
    _name = [name copy];
}
- (NSString *)name
{
    return  _name;
}
@end
