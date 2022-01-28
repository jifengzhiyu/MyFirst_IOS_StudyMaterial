//
//  Student.m
//  继承注意
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Student.h"

@implementation Student
- (void)setStuNmuber:(NSString*)stuNumber{
    _stuNumber = stuNumber;
}
- (NSString*)stuNumber{
    return _stuNumber;
}
- (void)sayHiStudent{
    NSLog(@"student你好呀");
}
@end
