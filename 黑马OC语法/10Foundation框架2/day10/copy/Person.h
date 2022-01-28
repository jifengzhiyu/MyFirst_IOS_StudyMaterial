//
//  Person.h
//  copy
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    NSString * _name;
    
}
//@property(nonatomic,copy) NSString * name;
- (void)setName:(NSString*) name;
- (NSString *)name;
@end

NS_ASSUME_NONNULL_END
