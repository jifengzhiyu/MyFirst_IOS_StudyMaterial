//
//  This file is designed to be customized by YOU.
//  
//  Copy this file and rename it to "XMPPFramework.h". Then add it to your project.
//  As you pick and choose which parts of the framework you need for your application, add them to this header file.
//  
//  Various modules available within the framework optionally interact with each other.
//  E.g. The XMPPPing module utilizes the XMPPCapabilities module to advertise support XEP-0199.
// 
//  However, the modules can only interact if they're both added to your xcode project.
//  E.g. If XMPPCapabilities isn't a part of your xcode project, then XMPPPing shouldn't attempt to reference it.
// 
//  So how do the individual modules know if other modules are available?
//  Via this header file.
// 
//  If you #import "XMPPCapabilities.h" in this file, then _XMPP_CAPABILITIES_H will be defined for other modules.
//  And they can automatically take advantage of it.
//

//  CUSTOMIZE ME !
//  THIS HEADER FILE SHOULD BE TAILORED TO MATCH YOUR APPLICATION.

//  The following is standard:

#import "XMPP.h"

//自动重连
#import "XMPPReconnect.h"

//心跳检测
#import "XMPPAutoPing.h"

//导入功能模块
#import "XMPPRoster.h"

//好友存储管理
#import "XMPPRosterCoreDataStorage.h"
//好友的实体
#import "XMPPUserCoreDataStorageObject.h"


//聊天模块
#import "XMPPMessageArchiving.h"

//聊天信息的存储管理
#import "XMPPMessageArchivingCoreDataStorage.h"

//两个实体 消息实体   最近联系人实体
#import "XMPPMessageArchiving_Message_CoreDataObject.h"
#import "XMPPMessageArchiving_Contact_CoreDataObject.h"

//自己个人资料功能模块
#import "XMPPvCardTempModule.h"

//个人资料内存存储
#import "XMPPvCardTemp.h"

//个人资料的存储器,不自己和别人
#import "XMPPvCardCoreDataStorage.h"

//个人资料的实体对象
#import "XMPPvCardCoreDataStorageObject.h"

//别人个人资料
#import "XMPPvCardAvatarModule.h"

//别人个人资料实体对象
#import "XMPPvCardAvatarCoreDataStorageObject.h"


//导入群聊功能类
#import "XMPPMUC.h"

//导入聊天室功能类
#import "XMPPRoom.h"

//数据存储管理
#import "XMPPRoomCoreDataStorage.h"
