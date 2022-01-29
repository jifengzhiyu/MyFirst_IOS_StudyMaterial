//
//  Microblog.m
//  微博练习
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import "Microblog.h"

@implementation Microblog
- (void)dealloc
{
    NSLog(@"微博删了");
    [_content release];
    [_imgURL release];
    [_user release];
    [_zhuanFaBlog release];
    [super dealloc];
}
@end
