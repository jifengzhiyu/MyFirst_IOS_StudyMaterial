//
//  Person.h
//  作业
//
//  Created by 翟佳阳 on 2021/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 1、人类：
 姓名，性别，年龄
 */
typedef enum{
    GenderMale,
    GenderFemale
}Gender;
@interface Person : NSObject
{
    NSString *_name;
    Gender _gender;
    int _age;
}
- (void)setName:(NSString*)name;
- (NSString*)name;

- (void)setGender:(Gender)gender;
- (Gender)gender;

- (void)setAge:(int)age;
- (int)age;
@end

NS_ASSUME_NONNULL_END
