//
//  Person.h
//  继承的本质
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    NSString* _name;
    
}
- (void)sayHi;
@end

NS_ASSUME_NONNULL_END
