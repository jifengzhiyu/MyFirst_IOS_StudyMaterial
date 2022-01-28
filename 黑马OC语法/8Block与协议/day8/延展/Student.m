//
//  Student.m
//  延展
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import "Student.h"

//延展
@interface Student ()
{
    NSString * _name;
}
@property(nonatomic,assign)int age;
- (void)study;
@end


@implementation Student
- (void)study
{
    NSLog(@"学习");
    
}
@end
