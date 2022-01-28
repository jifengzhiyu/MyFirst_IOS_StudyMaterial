//
//  Person.h
//  NSDictionary
//
//  Created by 翟佳阳 on 2021/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property(nonatomic,strong)NSString * name;
- (instancetype)initWithName:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
