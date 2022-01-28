//
//  Person.h
//  点
//
//  Created by 翟佳阳 on 2021/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    
    NSString* _name;
    int _age;
}
- (void)setName:(NSString*)name;
- (NSString*)name;
   
- (void)setAge:(int)age;
- (int)age;
@end

NS_ASSUME_NONNULL_END
