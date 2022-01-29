//
//  Person.h
//  里氏替换原则
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    NSString* _name;
    int _age;
    float _height;
    float _weight;
}
- (void)setName:(NSString*)name;
- (NSString*)name;

- (void)setAge:(int)age;
- (int)age;

- (void)setHeight:(float)height;
- (float)height;

- (void)setWeight:(float)weight;
- (float)weight;
@end

NS_ASSUME_NONNULL_END
