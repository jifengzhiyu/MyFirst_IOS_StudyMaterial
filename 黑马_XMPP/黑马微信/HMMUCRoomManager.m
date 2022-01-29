//
//  HMMUCRoomManager.m
//  黑马微信
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMMUCRoomManager.h"


@interface HMMUCRoomManager ()<XMPPMUCDelegate,XMPPRoomDelegate>

@property(nonatomic,strong)NSMutableDictionary *roomDict;

@end

@implementation HMMUCRoomManager

static HMMUCRoomManager *share;
//单例实现
+(instancetype)shareMUCRoom
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [HMMUCRoomManager new];
    });
    return share;
}

-(NSMutableDictionary *)roomDict
{
    if (_roomDict == nil) {
        _roomDict  = [NSMutableDictionary dictionary];
    }
    return _roomDict;
}

//通过get方法实现功能类
-(XMPPMUC *)xmppmuc
{
    if (_xmppmuc == nil) {
        //创建对象
        _xmppmuc = [[XMPPMUC alloc]initWithDispatchQueue:dispatch_get_main_queue()];
        
        //设置代理
        [_xmppmuc addDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        //激活
        [_xmppmuc activate:[HMManagerStream shareMananger].xmppStream];
    }
    return _xmppmuc;

}


-(XMPPRoom *)xmpproom
{
    if (_xmpproom == nil) {
        //第一步创建对象
        _xmpproom = [[XMPPRoom alloc]initWithDispatchQueue:dispatch_get_main_queue()];
    }
    return _xmpproom;

}

//实现加入房间
-(void)joinOrCreateWithRoomJid:(XMPPJID *)roomjid andNickName:(NSString *)nickname
{
    //创建房间
    XMPPRoom *room = [[XMPPRoom alloc]initWithRoomStorage:[XMPPRoomCoreDataStorage sharedInstance] jid:roomjid dispatchQueue:dispatch_get_main_queue()];
  
    //激活
    [room activate:[HMManagerStream shareMananger].xmppStream];
    
    //存放在数组里面
    self.roomDict[roomjid] = room;
    
    //加入房间,房间如果存在则直接加入,如果房间不存在创建一个房间并且加入该房间
    [room joinRoomUsingNickname:nickname history:nil];
    
    
    //设置代理
    [room addDelegate:self delegateQueue:dispatch_get_main_queue()];
    

}

-(void)xmppRoomDidJoin:(XMPPRoom *)sender
{
    //需对房间进行配置
    [sender configureRoomUsingOptions:nil];
    
    //    [sender fetchConfigurationForm];
    
    [sender inviteUser:[XMPPJID jidWithUser:@"xiaoliu" domain:@"heima.itcast.cn" resource:nil] withMessage:@"小六你妈叫你回家吃饭"];

}
-(void)xmppRoomDidCreate:(XMPPRoom *)sender
{
 
}

@end
