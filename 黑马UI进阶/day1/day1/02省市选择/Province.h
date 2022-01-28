//
//  Province.h
//  02省市选择
//
//  Created by 翟佳阳 on 2021/9/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Province : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray * cities;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)provinceWithDict:(NSDictionary *)dict;



@end

NS_ASSUME_NONNULL_END
