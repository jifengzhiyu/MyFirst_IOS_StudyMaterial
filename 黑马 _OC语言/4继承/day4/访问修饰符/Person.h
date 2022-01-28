//
//  Person.h
//  访问修饰符
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    @private
    //@protected
    NSString* _name;
    int _age;
    /*
     @private
     NSString* _name;
     
     @public
     int _age;
     int _x;
     
     @protected
     int _y;
     */
}
- (void)sayHi;
- (void)setName:(NSString*)name;
- (NSString*)name;
@end

NS_ASSUME_NONNULL_END
