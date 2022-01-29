//
//  HMManagerStream.h
//  黑马微信
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMManagerStream : NSObject

//创建一个stream 流
@property(nonatomic,strong)XMPPStream *xmppStream;

//接收密码
@property(nonatomic,copy)NSString *password;

//创建自动重连对象
@property(nonatomic,strong)XMPPReconnect *xmppReconnect;


//创建心跳检测对象
@property(nonatomic,strong)XMPPAutoPing *xmppAutoPing;

//创建好友列表功能模块
@property(nonatomic,strong)XMPPRoster *xmppRoster;

//创建聊天功能模块对象
@property(nonatomic,strong)XMPPMessageArchiving *xmppMessageArchiving;


//自己个人资料的功能类
@property(nonatomic,strong)XMPPvCardTempModule *xmppvCardTempMoudle;

//别人个人资料的
@property(nonatomic,strong)XMPPvCardAvatarModule *xmppvCardAvatarModule;



+ (instancetype)shareMananger;

//连接到服务器登陆
- (void)loginToserver:(XMPPJID *)myJid andPassWord:(NSString *)password;

@end
