//
//  Student.h
//  继承的本质
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : Person
{
    NSString* _stuNumber;
}
- (void)study;

@end

NS_ASSUME_NONNULL_END
