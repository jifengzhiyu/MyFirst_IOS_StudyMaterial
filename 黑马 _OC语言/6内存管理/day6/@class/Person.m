//
//  Person.m
//  @Class
//
//  Created by 翟佳阳 on 2021/8/12.
//

#import "Person.h"
#import "Book.h"
@implementation Person

- (void)dealloc{
    NSLog(@"人挂了");
    [_name release];
    [_book release];
    [super dealloc];
}
- (void)read{
    [_book chuanboZhishi];
}
@end
