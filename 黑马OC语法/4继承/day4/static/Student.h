//
//  Student.h
//  static
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
{
    int _number;
    NSString *_name;
    int _age;
}
- (void)setNumber:(int)number;
- (int)number;

- (void)setName:(NSString*)name;
- (NSString*)name;

- (void)setAge:(int)age;
- (int)age;

+ (instancetype)student;
+ (instancetype)studentWithName:(NSString*)name andAge:(int)age;
 
@end

NS_ASSUME_NONNULL_END
