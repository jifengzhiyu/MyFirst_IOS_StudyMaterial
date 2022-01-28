//
//  Person.h
//  属性的封装
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    
    NSString* _name;
    int _age;
}

- (void)sayHi;
- (void)setAge:(int)age;
- (void)setName:(NSString*)name;
- (int)age;
- (NSString*)name;
@end

NS_ASSUME_NONNULL_END
