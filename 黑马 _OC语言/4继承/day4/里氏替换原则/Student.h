//
//  Student.h
//  里氏替换原则
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : Person
{
    NSString* _stuNumber;
}
- (void)setStuNumber:(NSString*)stuNumber;
- (NSString*)stuNumber;
- (void)study;
@end

NS_ASSUME_NONNULL_END
