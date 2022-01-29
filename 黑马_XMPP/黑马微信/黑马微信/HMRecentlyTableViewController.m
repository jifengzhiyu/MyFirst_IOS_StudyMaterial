//
//  HMRecentlyTableViewController.m
//  黑马微信
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMRecentlyTableViewController.h"
#import "HMChatViewController.h"

@interface HMRecentlyTableViewController ()<NSFetchedResultsControllerDelegate,XMPPvCardAvatarDelegate>

//控制器查询数据
@property(nonatomic,strong)NSFetchedResultsController *fetchedresultscontroller;

@property(nonatomic,strong)NSArray *recentlyArrs;

@end

@implementation HMRecentlyTableViewController

//懒加载
-(NSArray *)recentlyArrs
{
    if (_recentlyArrs == nil) {
        _recentlyArrs = [NSArray array];
    }
    return _recentlyArrs;
}

-(NSFetchedResultsController *)fetchedresultscontroller
{
    if (_fetchedresultscontroller == nil) {
        //创建查询请求
        NSFetchRequest *fetchrequest = [[NSFetchRequest alloc]init];
        
        //实体
      fetchrequest.entity =   [NSEntityDescription entityForName:@"XMPPMessageArchiving_Contact_CoreDataObject" inManagedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext];
        //谓词
//        NSPredicate *pre = [NSPredicate predicateWithFormat:@""];

        //排序
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"mostRecentMessageTimestamp" ascending:NO];
        fetchrequest.sortDescriptors = @[sort];
        
        //查询创建
        
        _fetchedresultscontroller = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchrequest managedObjectContext:[XMPPMessageArchivingCoreDataStorage sharedInstance].mainThreadManagedObjectContext sectionNameKeyPath:nil cacheName:@"Recently"];
        
        //设置代理
        _fetchedresultscontroller.delegate = self;
    }
    return _fetchedresultscontroller;

}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //数据获取
    self.recentlyArrs = self.fetchedresultscontroller.fetchedObjects;
    //数据刷新
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置代理
    [[HMManagerStream shareMananger].xmppvCardAvatarModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    [NSFetchedResultsController deleteCacheWithName:@"Recently"];
    //数据查询
    [self.fetchedresultscontroller performFetch:nil];
    
    self.recentlyArrs = self.fetchedresultscontroller.fetchedObjects;
    //刷新
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.recentlyArrs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//获取数据
    XMPPMessageArchiving_Contact_CoreDataObject *contact = self.recentlyArrs[indexPath.row];
    
    //创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Recently_Cell"];
    
    //设置cell
       UILabel *name = [cell viewWithTag:1002];
    UILabel *lastmessage = [cell viewWithTag:1003];
    UIImageView *icon = [cell viewWithTag:1001];
    name.text = contact.bareJidStr;
    lastmessage.text = contact.mostRecentMessageBody;
    
    icon.image = [UIImage imageWithData:[[HMManagerStream shareMananger].xmppvCardAvatarModule photoDataForJID:contact.bareJid] ];
    
    //返回cell
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)cell
{
    //获取数据
    
    XMPPMessageArchiving_Contact_CoreDataObject *contact = self.recentlyArrs[[self.tableView indexPathForCell:cell].row];

    //设置jid
    HMChatViewController *chatVC = segue.destinationViewController;
    chatVC.userJid = contact.bareJid;
    
}

-(void)xmppvCardAvatarModule:(XMPPvCardAvatarModule *)vCardTempModule didReceivePhoto:(UIImage *)photo forJID:(XMPPJID *)jid
{
    //数据刷新
    [self.tableView reloadData];
}
- (IBAction)addRoom:(id)sender {
    
    //加入到房间
    [[HMMUCRoomManager shareMUCRoom] joinOrCreateWithRoomJid:[XMPPJID jidWithUser:@"iOS" domain:@"ios.heima.itcast.cn" resource:nil] andNickName:@"爪机版lisi"];
}
@end
