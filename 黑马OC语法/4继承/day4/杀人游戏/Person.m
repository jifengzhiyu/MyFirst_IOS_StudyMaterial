//
//  Person.m
//  杀人游戏
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
- (void)help{
    NSLog(@"啊啊啊");
}
@end
