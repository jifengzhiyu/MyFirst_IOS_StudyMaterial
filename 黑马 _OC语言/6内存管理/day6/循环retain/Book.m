//
//  Book.m
//  循环retain
//
//  Created by 翟佳阳 on 2021/8/13.
//

#import "Book.h"
#import"Person.h"
@implementation Book
- (void)castZhiShi{
    NSLog(@"赚大钱");
}
- (void)dealloc{

    [_name release];
    [_owner release];
    NSLog(@"书没了");
    [super dealloc];
}
@end
