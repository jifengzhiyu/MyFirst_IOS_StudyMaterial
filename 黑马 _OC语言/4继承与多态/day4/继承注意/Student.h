//
//  Student.h
//  继承注意
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : Person

- (void)setStuNmuber:(NSString*)stuNumber;
- (NSString*)stuNumber;
- (void)sayHiStudent;
@end

NS_ASSUME_NONNULL_END
