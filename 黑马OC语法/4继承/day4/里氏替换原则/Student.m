//
//  Student.m
//  里氏替换原则
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Student.h"

@implementation Student
- (void)setStuNumber:(NSString*)stuNumber{
    _stuNumber = stuNumber;
}
- (NSString*)stuNumber{
    return _stuNumber;
}
- (void)study{
    NSLog(@"我在学习");
}
@end
