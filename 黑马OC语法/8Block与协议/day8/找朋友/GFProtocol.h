//
//  GFProtocol.h
//  找朋友
//
//  Created by 翟佳阳 on 2021/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 绿朋友协议
@protocol GFProtocol <NSObject>
@required
- (void)wash;
- (void)cook;

@optional
-(void)job;
@end

NS_ASSUME_NONNULL_END
