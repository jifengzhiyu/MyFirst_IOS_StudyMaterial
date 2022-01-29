//
//  Student.m
//  作业
//
//  Created by 翟佳阳 on 2021/8/7.
//

#import "Student.h"

@implementation Student
- (void)setStuNumber:(NSString*)stuNumber{
    _stuNumber = stuNumber;
}
- (NSString*)stuNmber{
    return _stuNumber;
}
- (void)setBook:(Book*)book{
    _book = book;
}
- (Book*)book{
    return _book;
}

@end
