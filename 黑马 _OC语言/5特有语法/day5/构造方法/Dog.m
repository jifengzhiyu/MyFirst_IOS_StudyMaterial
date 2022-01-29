//
//  Dog.m
//  构造方法
//
//  Created by 翟佳阳 on 2021/8/11.
//

#import "Dog.h"

@implementation Dog
- (void)shout{
    NSLog(@"汪汪。。。。.");
}
- (instancetype)initWithName:(NSString*)name andAge:(int)age{
    if(self = [super init]){
        self.name = name;
        self.age = age;
    }
    return self;
}
@end
