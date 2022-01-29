//
//  HMManagerStream.m
//  黑马微信
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMManagerStream.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "XMPPLogging.h"

@interface HMManagerStream ()<XMPPStreamDelegate,XMPPRosterDelegate>

@end

@implementation HMManagerStream

//单例
static HMManagerStream *share;
+(instancetype)shareMananger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [HMManagerStream new];
        
        //设置打印的日志
        [DDLog  addLogger:[DDTTYLogger sharedInstance] withLogLevel:XMPP_LOG_FLAG_SEND_RECV];
    });
    return share;

}

//配置stream流
-(XMPPStream *)xmppStream
{
    if (_xmppStream == nil) {
        //创建对象
        _xmppStream = [[XMPPStream alloc]init];
        //设置属性
        _xmppStream.hostName = @"127.0.0.1";
        _xmppStream.hostPort = 5222;
        
        
        //设置代理 是多播代理
        [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        //连接到服务器
        /**
         * Connects to the configured hostName on the configured hostPort.
         * The timeout is optional. To not time out use XMPPStreamTimeoutNone.
         * If the hostName or myJID are not set, this method will return NO and set the error parameter.
         **/
//        [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:nil];
    }
    return _xmppStream;

}


//连接服务器并且登陆
-(void)loginToserver:(XMPPJID *)myJid andPassWord:(NSString *)password
{
    //设置myJID
    [self.xmppStream setMyJID:myJid];
    
    //保存密码
    self.password = password;
    //连接
     [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:nil];
    
    //激活所有功能模块
    [self activity];
}




#pragma 所有功能模块
//自动重连
-(XMPPReconnect *)xmppReconnect
{
    if (_xmppReconnect == nil) {
        //创建的对象
        _xmppReconnect = [[XMPPReconnect alloc]initWithDispatchQueue:dispatch_get_main_queue()];
        
        //设置参数
        _xmppReconnect.reconnectTimerInterval = 2;
        
        
        //设置代理
        
    }
    return _xmppReconnect;
}

//创建心跳检测对象
-(XMPPAutoPing *)xmppAutoPing
{
    if (_xmppAutoPing == nil) {
        //创建对象
        _xmppAutoPing = [[XMPPAutoPing alloc]initWithDispatchQueue:dispatch_get_main_queue()];
        
        
        //设置参数代理
        _xmppAutoPing.pingInterval = 3;
    }
    return _xmppAutoPing;
}

//好友列表功能模块
-(XMPPRoster *)xmppRoster
{
    if (_xmppRoster == nil) {
        //创建对象
        _xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:[XMPPRosterCoreDataStorage sharedInstance] dispatchQueue:dispatch_get_global_queue(0, 0)];
        //设置参数
        //是否自动查找新的好友数据
        _xmppRoster.autoFetchRoster = YES;
        
        //是否自动删除用户存储的数据呢,不需要
        _xmppRoster.autoClearAllUsersAndResources = NO;
        
        //如果自动接收XMPP 会帮我们做一个加好友的操作,代理方法也不会被调用了
        _xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = NO;
        
        //设置代理
        [_xmppRoster addDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    }
    return _xmppRoster;
}

//消息功能模块
-(XMPPMessageArchiving *)xmppMessageArchiving
{
    if (_xmppMessageArchiving == nil) {
        //创建对象
        _xmppMessageArchiving = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:[XMPPMessageArchivingCoreDataStorage sharedInstance] dispatchQueue:dispatch_get_main_queue()];
        
        //设置参数  代理
    }
    return _xmppMessageArchiving;
}


//自己的个人资料
-(XMPPvCardTempModule *)xmppvCardTempMoudle
{
    if (_xmppvCardTempMoudle == nil) {
        //创建对象
        _xmppvCardTempMoudle = [[XMPPvCardTempModule alloc]initWithvCardStorage:[XMPPvCardCoreDataStorage sharedInstance] dispatchQueue:dispatch_get_main_queue()];
        
        //设置参数
        
        //设置代理
        
    }
    return _xmppvCardTempMoudle;
}

//指定用户个人资料功能模块
-(XMPPvCardAvatarModule *)xmppvCardAvatarModule
{
    if (_xmppvCardAvatarModule == nil) {
        //创建
        _xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_xmppvCardTempMoudle dispatchQueue:dispatch_get_main_queue()];
        
        
    }
    return _xmppvCardAvatarModule;

}

//激活模块
- (void)activity
{
    //1.自动重连 激活
    [self.xmppReconnect activate:self.xmppStream];
    
    //激活心跳检测模块
//    [self.xmppAutoPing activate:self.xmppStream];
    
    //使用好友列表 需要激活
    [self.xmppRoster activate:self.xmppStream];
    
    //激活消息模块
    [self.xmppMessageArchiving activate:self.xmppStream];
    
    //个人资料
    [self.xmppvCardTempMoudle activate:self.xmppStream];
    
    //别人的个人资料
    [self.xmppvCardAvatarModule activate:self.xmppStream];

}


//通过代理方法告诉我们连接是否成功
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    //认证
    [self.xmppStream authenticateWithPassword:self.password error:nil];
    
    //还可以注册 匿名登陆
//    [self.xmppStream authenticateAnonymously:nil];
//    [self.xmppStream registerWithPassword:nil error:nil];
}

-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    //如果成功 则可以出席
    XMPPPresence *presence = [XMPPPresence presence];
    
    //添加出席状态
    [presence addChild:[DDXMLElement elementWithName:@"show" stringValue:@"dnd"]];
    [presence addChild:[DDXMLElement elementWithName:@"status" stringValue:@"别来烦我!!"]];
    
    //通过stream 告诉服务器我需要出席
    [self.xmppStream sendElement:presence];
}

//通过代理接收数据
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
//    NSLog(@"接收到的消息时= %@",message.body);
    UILocalNotification *noti = [[UILocalNotification alloc]init];
    
//    [noti setAlertTitle:[NSString stringWithFormat:@"来自%@ :%@消息",message.from,message.body]];
    [noti setAlertBody:[NSString stringWithFormat:@"来自%@ :%@消息",message.from,message.body]];
    
    //设置appicon图标
    [noti setApplicationIconBadgeNumber:1];
    
    //弹出本地通知
    [[UIApplication sharedApplication] presentLocalNotificationNow:noti];
}


@end
