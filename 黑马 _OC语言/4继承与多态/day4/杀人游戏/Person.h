//
//  Person.h
//  杀人游戏
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    NSString* _name;
}
- (void)setName:(NSString*)name;
- (NSString*)name;
- (void)help;
@end

NS_ASSUME_NONNULL_END
