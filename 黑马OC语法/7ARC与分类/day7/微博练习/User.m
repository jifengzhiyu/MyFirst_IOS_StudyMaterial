//
//  User.m
//  微博练习
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import "User.h"

@implementation User
- (void)dealloc
{
    NSLog(@"用户死了");
    [_nickName release];
    [_account release];
    [super dealloc];
}
@end
