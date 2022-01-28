//
//  Book.m
//  ARC机制下的循环引用
//
//  Created by 翟佳阳 on 2021/8/15.
//

#import "Book.h"
#import "Person.h"
@implementation Book
- (void)dealloc
{
    NSLog(@"书被烧了");
}
@end
