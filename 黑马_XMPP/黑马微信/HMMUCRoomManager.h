//
//  HMMUCRoomManager.h
//  黑马微信
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMMUCRoomManager : NSObject
//多用户聊天功能类
@property(nonatomic,strong)XMPPMUC *xmppmuc;

//聊天室的功能类
@property(nonatomic,strong)XMPPRoom *xmpproom;

- (void)joinOrCreateWithRoomJid:(XMPPJID *)roomjid andNickName:(NSString *)nickname;

//单例
+ (instancetype)shareMUCRoom;
@end
