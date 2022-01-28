//
//  Person.m
//  NSDictionary
//
//  Created by 翟佳阳 on 2021/8/23.
//

#import "Person.h"

@implementation Person
- (instancetype)initWithName:(NSString*)name
{
    if(self = [super init])
    {
        self.name = name;
    }
    return self;
}
@end
