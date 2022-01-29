# XMPP第四天

	1.个人资料 搭建
		包括头像，和框架的修改完善
//7.头像&个人资料

//个人资料模块

#import "XMPPvCardTempModule.h"

//个人资料的内存对象

#import "XMPPvCardTemp.h"

//存储器

#import "XMPPvCardCoreDataStorage.h"

//个人资料的实体对象

#import "XMPPvCardCoreDataStorageObject.h"

//头像模块

#import "XMPPvCardAvatarModule.h"

//头像的实体对象

#import “XMPPvCardAvatarCoreDataStorageObject.h"



	2.  //6.个人资料&头像 功能模块创建

    _xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:[XMPPvCardCoreDataStorage sharedInstance]];// 个人资料

        _xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_xmppvCardTempModule];// 头像功能

        [_xmppvCardTempModule activate:self.xmppStream];// 激活模块

    [_xmppvCardAvatarModule activate:self.xmppStream];//激活模块



通过代理方法    [[HMXMPPManager sharedInstance].xmppvCardTempModule addDelegate:self delegateQueue:dispatch_get_main_queue()];

反馈动作，告诉我们完成了哪些内容


	2.聊天室 搭建

两个模块  XMPPMUC（相当于yy房间）
同样，1.先创建模块对象
 _xmppMUC = [[XMPPMUC alloc] init];

2.设置代理
 [_xmppMUC addDelegate:self delegateQueue:dispatch_get_main_queue()];
3. 激活
        [_xmppMUC activate:[HMXMPPManager sharedInstance].xmppStream];

XMPPRoom（yy房间内部的小房间）
1.创建对象

 XMPPRoom * room = [[XMPPRoom alloc] initWithRoomStorage:[XMPPRoomCoreDataStorage sharedInstance] jid:roomJID];

2. 设置代理

[room addDelegate:self delegateQueue:dispatch_get_main_queue()];

3.激活模块

    [room activate:[HMXMPPManager sharedInstance].xmppStream];



反馈代理方法

  //尝试邀请别人
   [sender inviteUser:[XMPPJID jidWithUser:@"zhangsan" domain:@"im.itheima.com" resource:nil] withMessage:@"张三快到碗里来"];



// 如果说是临时房间,那么人数变为0的时候会被摧毁

// 如果是持久房间,那么除非所有者删除这个房间,否则不会被摧毁

- (void)xmppRoomDidDestroy:(XMPPRoom *)sender {



}

//配置代理方法

- (void)xmppRoom:(XMPPRoom *)sender didFetchConfigurationForm:(DDXMLElement *)configForm {

    //NSLog(@"%@",[[configForm description] kv_decodeHTMLCharacterEntities]);

}

	3.抽屉效果
container View 可以放任何东西，控制器，导航控制器，tabor控制器
约束拖线 根据手势操作 改变约束的值


