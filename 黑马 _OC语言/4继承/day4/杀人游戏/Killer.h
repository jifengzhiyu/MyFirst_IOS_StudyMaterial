//
//  Killer.h
//  杀人游戏
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import <Foundation/Foundation.h>
#import "Person.h"
NS_ASSUME_NONNULL_BEGIN

@interface Killer : NSObject
- (void)KillWith:(Person*)per;
@end

NS_ASSUME_NONNULL_END
