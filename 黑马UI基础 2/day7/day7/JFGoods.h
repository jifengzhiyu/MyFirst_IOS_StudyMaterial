//
//  JFGoods.h
//  day7
//
//  Created by 翟佳阳 on 2021/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFGoods : NSObject
@property (nonatomic,copy)NSString *buyCount;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *icon;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)goodsWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
