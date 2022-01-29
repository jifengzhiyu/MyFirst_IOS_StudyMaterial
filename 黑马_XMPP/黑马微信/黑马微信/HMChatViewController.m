//
//  HMChatViewController.m
//  黑马微信
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMChatViewController.h"

@interface HMChatViewController ()<NSFetchedResultsControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,XMPPvCardAvatarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *sendMessage;

@property(nonatomic,strong)NSFetchedResultsController *fetchedresultscontroller;

//数据用于数据显示
@property(nonatomic,strong)NSArray *chatArrs;

@end

@implementation HMChatViewController

//懒加载数组
-(NSArray *)chatArrs
{
    if (_chatArrs == nil) {
        _chatArrs = [NSArray array];
    }
    return _chatArrs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSFetchedResultsController deleteCacheWithName:@"messages"];
    
    //设置代理
    [[HMManagerStream shareMananger].xmppvCardAvatarModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    //查询聊天记录
    [self.fetchedresultscontroller performFetch:nil];
    self.chatArrs = self.fetchedresultscontroller.fetchedObjects;
    //        //刷新
    [self.tableview reloadData];
    if (self.chatArrs.count > 5) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:self.chatArrs.count -1 inSection:0];
        
        [self.tableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        //        //刷新
//                [self.tableview reloadData];
        
    }
}

-(NSFetchedResultsController *)fetchedresultscontroller
{
    if (_fetchedresultscontroller == nil) {
        //查询请求
        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
        
        //实体
      NSEntityDescription *entity =   [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
        
        fetchrequest.entity = entity;
        
        //谓词
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"bareJidStr = %@",self.userJid.bare];
        fetchrequest.predicate = pre;
        
        //排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
        fetchrequest.sortDescriptors = @[sort];
        //创建查询控制器
        
        _fetchedresultscontroller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"messages"];
        
        //设置代理
        _fetchedresultscontroller.delegate = self;
    }
    return _fetchedresultscontroller;

}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    
    //排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    //获取排序之后的数据
   self.chatArrs =  [self.fetchedresultscontroller.fetchedObjects sortedArrayUsingDescriptors:@[sort]];
    //获取新的数据
//    self.chatArrs = self.fetchedresultscontroller.fetchedObjects;
    //刷新
    [self.tableview reloadData];
    //滚动到最底下
    
    if (self.chatArrs.count > 5) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:self.chatArrs.count -1 inSection:0];
        
        [self.tableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//        //刷新
//        [self.tableview reloadData];
        
    }
   

 
  
}


#pragma tableview 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",self.chatArrs.count);
    return self.chatArrs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    XMPPMessageArchiving_Message_CoreDataObject *msg = self.chatArrs[indexPath.row];
    
    //创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:msg.isOutgoing?@"Right_Cell":@"Left_Cell"];
    
    //cell赋值
       UILabel *messageLable = [cell viewWithTag:1002];
       messageLable.text = msg.body;
    
    //头像设置
    UIImageView *icon = [cell viewWithTag:1001];
    if (msg.isOutgoing) {//自己的头像
        icon.image = [UIImage imageWithData:[HMManagerStream shareMananger].xmppvCardTempMoudle.myvCardTemp.photo];
    }else
    {
        //别人的头像
        icon.image = [UIImage imageWithData:[[HMManagerStream shareMananger].xmppvCardAvatarModule photoDataForJID:msg.bareJid]];
    
    }
    
    
    //返回cell
    return cell;

}

//键盘取消
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.sendMessage endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //发消息
    XMPPMessage *message = [XMPPMessage messageWithType:@"groupchat" to:self.userJid];
    [message addBody:self.sendMessage.text];
    
    [[HMManagerStream shareMananger].xmppStream sendElement:message];
    
    //刷新数据
    [self.tableview reloadData];
    //键盘
    self.sendMessage.text = @"";
    return YES;
}

-(void)xmppvCardAvatarModule:(XMPPvCardAvatarModule *)vCardTempModule didReceivePhoto:(UIImage *)photo forJID:(XMPPJID *)jid
{
    //    //数据刷新
        [self.tableview reloadData];
}

//-(void)xmppvCardTempModuleDidUpdateMyvCard:(XMPPvCardTempModule *)vCardTempModule
//{
//    //数据刷新
//    [self.tableview reloadData];
//}
@end
