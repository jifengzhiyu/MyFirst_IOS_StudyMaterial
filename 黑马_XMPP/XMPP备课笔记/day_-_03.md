# XMPP第三天 功能模块使用秘籍
    5个步骤
    头文件
    创建对象
    设置代理
    设置参数
    激活模块
    功能模块做的事情会通过代理方法告诉我们，会有些参数通过代理返回给我们！

## 实战
###自动重练(断线重连)
    1.头文件引入
    #import"XMPPReconnect.h"
    2.创建对象
    _xmppReconnect = [[XMPPReconnect alloc]initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)];

    3.设置代理
    [_xmppReconnect addDelegate:self delegateQueue:dispatch_get_global_queue

    4.设置一些参数
      _xmppReconnect.reconnectTimerInterval = 1;

    5.激活！！
     [self.xmppReconnect activate:self.xmppStream];

     通过5步，功能模块已经可以正常工作了，此功能模块工作的事情会通过代理告诉我们。


###心跳检测
    1.头文件引入
        #import"XMPPAutoPing.h"
    2.  创建对象
        _xmppAutoPing = [[XMPPAutoPing alloc]initWithDispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)];
    3.设置代理
         [_xmppAutoPing addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)];
    4.设置参数
          _xmppAutoPing.pingInterval = 260;
    5.激活
         [self.xmppAutoPing activate:self.xmppStream];

###好友系统（通讯录）
    1.头文件引入
        #import "XMPPRoster.h"
        #import "XMPPRosterCoreDataStorage.h"
        #import "XMPPUserCoreDataStorageObject.h"
    2.创建对象
    _xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:[XMPPRosterCoreDataStorage sharedInstance] dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)];
    3.设置代理
    [_xmppRoster addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)];
    4.设置参数
          //自动获取好友列表
        _xmppRoster.autoFetchRoster = YES;
        //离线不删除好友列表
        _xmppRoster.autoClearAllUsersAndResources = NO;
        //是否自动接收出席的丁略（如果自动xmpp内部帮我们实现，就不提供其他代理功能）
        _xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = NO;
    5.激活模块
        //好友激活模块
    [self.xmppRoster activate:self.xmppStream];


###消息记录
    1.头文件引入
        #import "XMPPMessageArchiving.h"
        #import "XMPPMessageArchivingCoreDataStorage.h"
        #import "XMPPMessageArchiving_Message_CoreDataObject.h"
    2.创建对象
     _xmppmessagearchiving = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:[XMPPMessageArchivingCoreDataStorage sharedInstance] dispatchQueue:dispatch_get_main_queue()];
    3.设置代理
    代理设置可以不放在工具类，最好在哪个控制器中使用就在那设置代理
    由于XMPP 使用的是多播代理，把代理都放在数组中，一次遍历
    使用起来很容易，在哪里需要在哪里添加
    4.设置参数

    5.激活模块
     [self.xmppmessagearchiving activate:self.xmppStream];

在聊天控制器中创建一个NSFetchedResultsControllerDelegate
对象，从CoreData中查找对应的消息实体对象数据
`注意`:需要添加代理，多播代理方式添加
通过 NSFetchedResultsControllerDelegate 获取消息实体对象数据`XMPPMessageArchiving_Message_CoreDataObject`
查询结果控制器的cacheName 是Message；
查询控制器需要执行
 [self.FetchedResultsController performFetch:nil];
 这个方法一旦被调用 ，立刻会获得相对应的数据
  self.ChatHistory = self.FetchedResultsController.fetchedObjects;
  查询到的数据会存在这个数组中
  通过查询控制器代理方法

  -(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{

NSSortDescriptor * sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
`#warning 一定要刷新`

    self.ChatHistory = [self.FetchedResultsController.fetchedObjects sortedArrayUsingDescriptors:@[sortDesc]];
    [self.ChatTableView reloadData];
    //滚动到底部
    if (self.ChatHistory.count > 0) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.ChatHistory.count-1 inSection:0];
        [self.ChatTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    [self.ChatTableView reloadData];

}

###发送消息
我们通过XMPPMesage 对象发送消息 通过内部的addBody方法添加消息
发送消息通过我们单例XMPPStream 发送
   [[HMXMPPManager sharedInstance].xmppStream sendElement:msg];

