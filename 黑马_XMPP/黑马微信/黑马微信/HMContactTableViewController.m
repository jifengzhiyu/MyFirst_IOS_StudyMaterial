//
//  HMContactTableViewController.m
//  黑马微信
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMContactTableViewController.h"
#import "HMChatViewController.h"

@interface HMContactTableViewController ()<NSFetchedResultsControllerDelegate,XMPPRosterDelegate>

//查询控制器
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultsController;

//好友列表数组
@property(nonatomic,strong)NSArray *contactArrs;

@end

@implementation HMContactTableViewController

//懒加载数组
-(NSArray *)contactArrs
{
    if (_contactArrs == nil) {
        _contactArrs = [NSArray array];
    }
    return _contactArrs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //执行查询操作 After executing this method, the fetched objects can be accessed with the property 'fetchedObjects'
    [NSFetchedResultsController deleteCacheWithName:@"contacts"];
    //好友代理设置
    [[HMManagerStream shareMananger].xmppRoster addDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    [self.fetchedResultsController performFetch:nil];
    
     //获取到数据
    self.contactArrs = self.fetchedResultsController.fetchedObjects;
    
    //刷新数据
    [self.tableView reloadData];
}

-(NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        //创建一个查询请求
        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
        
        //实体
     NSEntityDescription *entity =  [NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject" inManagedObjectContext:[XMPPRosterCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
        fetchrequest.entity = entity;
        
        //谓词
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"subscription = %@",@"both"];
        fetchrequest.predicate = pre;
        
        //排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"jidStr" ascending:YES];
        fetchrequest.sortDescriptors = @[sort];
        
        //创建fetchedResultsController对象
        _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPRosterCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"contacts"];
        
        //设置代理
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;

}

//当CoreData数据发送变化会调用该代理方法
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //最新的消息
       self.contactArrs = self.fetchedResultsController.fetchedObjects;
    //刷新数据
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.contactArrs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取数据
    XMPPUserCoreDataStorageObject *contact = self.contactArrs[indexPath.row];
    
    //创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Contact_Cell"];
    
    //给cell赋值
       UILabel *name =  [cell viewWithTag:1002];
        name.text = contact.jidStr;
    
    //设置别人的头像
    UIImageView *icon = [cell viewWithTag:1001];
    icon.image = [UIImage imageWithData:[[HMManagerStream shareMananger].xmppvCardAvatarModule photoDataForJID:contact.jid]];
    
    //返回cell
    return cell;
}

//添加好友
- (IBAction)addfriends:(id)sender {
    [[HMManagerStream shareMananger].xmppRoster addUser:[XMPPJID jidWithUser:@"wangwu" domain:@"heima.itcast.cn" resource:nil] withNickname:@"加好友有饭吃"];
    
}



-(void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    //同意添加对方为好友
    [[HMManagerStream shareMananger].xmppRoster acceptPresenceSubscriptionRequestFrom:[XMPPJID jidWithUser:@"wangwu" domain:@"heima.itcast.cn" resource:nil] andAddToRoster:YES];
    
 //刷新
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取数据
    XMPPUserCoreDataStorageObject *contact = self.contactArrs[indexPath.row];
    //删除好友
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[HMManagerStream shareMananger].xmppRoster removeUser:contact.jid];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell
{
    //获取数据
    XMPPUserCoreDataStorageObject *contact = self.contactArrs[[self.tableView indexPathForCell:cell].row];

    //获取目标控制器
    HMChatViewController *chatVC = segue.destinationViewController;
    //把目标的jid 传给聊天界面
    chatVC.userJid = contact.jid;
}

@end
