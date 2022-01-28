//
//  Person.m
//  id指针
//
//  Created by 翟佳阳 on 2021/8/9.
//

#import "Person.h"

@implementation Person
- (void)sayHi{
    NSLog(@"你好");
}
+(instancetype)person 
{
    return [self new];
}
@end
