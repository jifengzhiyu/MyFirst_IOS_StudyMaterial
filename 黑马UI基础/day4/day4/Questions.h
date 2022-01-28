//
//  Questions.h
//  day4
//
//  Created by 翟佳阳 on 2021/9/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Questions : NSObject
@property(nonatomic,copy)NSString * answer;
@property(nonatomic,copy)NSString * icon;
@property(nonatomic,copy)NSString * title;

@property(nonatomic,copy)NSArray * options;

-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)questionWithDict:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
