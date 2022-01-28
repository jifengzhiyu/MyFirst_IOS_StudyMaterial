//
//  Gril.h
//  找朋友
//
//  Created by 翟佳阳 on 2021/8/19.
//

#import <Foundation/Foundation.h>
#import "GFProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface Gril : NSObject <GFProtocol>
@property(nonatomic,strong)NSString * name;
@end

NS_ASSUME_NONNULL_END
