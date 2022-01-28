//
//  Book.m
//  @Class
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import "Book.h"

@implementation Book
- (void)chuanboZhishi{
    NSLog(@"学IT赚大钱");
}
- (void)dealloc{
    NSLog(@"书被烧了");
    [_name release];
    [_authorName release];
    [super dealloc];
}

@end
