//
//  Dog.m
//  对象作为类的属性
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import "Dog.h"

@implementation Dog 
- (void)shout{
    NSLog(@"汪汪，我叫%@，是一条%@狗，没事就叫唤",_name,_color);
}
@end
