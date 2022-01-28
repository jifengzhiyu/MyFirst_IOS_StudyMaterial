//
//  main.m
//  分组导航标记
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>
#pragma mark 人的声明
@interface Person : NSObject
{
    NSString* _name;
    int _age;
}
- (void)sayHi;
@end
#pragma mark 人的实现
@implementation Person
- (void)sayHi{
    NSLog(@"我是%@，今年%d岁",_name,_age);
}
@end

#paragma mark -

#pragma mark 狗的声明
@interface Dog : NSObject


@end

#pragma mark 狗的实现
@implementation Dog


@end


#paragma mark - 鸟的声明








@interface Brid : NSObject


@end

#pragma mark 鸟的实现
@implementation Brid


@end



int main(int argc, const char * argv[]) {
    
    return 0;
}
