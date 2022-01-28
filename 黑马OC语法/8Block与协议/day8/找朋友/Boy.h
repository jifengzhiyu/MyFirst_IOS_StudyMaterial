//
//  Boy.h
//  找朋友
//
//  Created by 翟佳阳 on 2021/8/19.
//

#import <Foundation/Foundation.h>
#import "GFProtocol.h"
#import "GFProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface Boy : NSObject <GFProtocol>
@property(nonatomic,strong)NSString * name;
@property(nonatomic,assign)int age;
@property(nonatomic,assign)int money;
@property(nonatomic,strong)id <GFProtocol> grilFriend;

- (void)love;
@end

NS_ASSUME_NONNULL_END
