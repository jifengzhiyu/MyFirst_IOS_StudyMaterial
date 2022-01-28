//
//  Person.m
//  static
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import "Person.h"

@implementation Person
- (void)sayHi{
    static int num = 12;
    num++;
    NSLog(@"num = %d",num);
}
@end
