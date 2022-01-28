//
//  JFMessage.h
//  day8
//
//  Created by 翟佳阳 on 2021/9/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    JFMessageTypeMe = 0,
    JFMessageTypeOther = 1
} JFMessageType;

@interface JFMessage : NSObject
@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,assign)JFMessageType type;
@property (nonatomic,assign)BOOL ishideTime;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)messageWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
