//
//  JFGroup.h
//  2好友列表
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFGroup : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int online;
@property (nonatomic, strong)NSArray *friends;
@property (nonatomic, assign) BOOL isVisible;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
