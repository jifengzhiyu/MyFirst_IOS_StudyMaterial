//
//  HMMoreClientViewController.m
//  Mac服务器01
//
//  Created by apple on 16/2/23.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMMoreClientViewController.h"
#import "HMClientManagerCoreData.h"
#import "Client.h"
#import "HMSendClientViewController.h"

@interface HMMoreClientViewController ()<NSTableViewDataSource,NSTableViewDelegate>
@property (weak) IBOutlet NSTableView *tableview;

@property(nonatomic,strong)NSDateFormatter *formatter;

//数组
@property(nonatomic,strong)NSArray *moreArrsEntity;
@end

@implementation HMMoreClientViewController

//时间格式化懒加载
-(NSDateFormatter *)formatter
{
    if (_formatter == nil) {
        //创建一个格式化
        _formatter = [[NSDateFormatter alloc]init];
        
        _formatter.dateFormat = @"MM - dd EEEE a hh:mm:ss.SSS";
        _formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        _formatter.weekdaySymbols = @[@"星期⑦",@"星期①",@"星期②",@"星期③",@"星期④",@"星期⑤",@"星期⑥",];
    }
    return _formatter;
}

//数组懒加载
-(NSArray *)moreArrsEntity
{
    if (_moreArrsEntity == nil) {
        _moreArrsEntity = [NSArray array];
    }
    return _moreArrsEntity;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    //数据加载也就是到CoreData中查询数据
    [self fetchData];
    
    
    //接收刷新通知 - 知道了新来的客户端
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fetchData) name:@"moreClientReloaddata" object:nil];
}

- (void)fetchData
{

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Client" inManagedObjectContext:[HMClientManagerCoreData shareManager].managerContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
//    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"connectTime" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];

    self.moreArrsEntity = [[HMClientManagerCoreData shareManager].managerContext executeFetchRequest:fetchRequest error:nil];
    //数据刷新
    [self.tableview reloadData];
 
}


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.moreArrsEntity.count;
}


- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row
{
    //提取数据
    Client *client = self.moreArrsEntity[row];
    
    if ([tableColumn.title isEqualToString:@"ip"]) {
        return client.ipaddress;
    }
    if ([tableColumn.title isEqualToString:@"port"]) {
        return client.portNumber;
    }
    if ([tableColumn.title isEqualToString:@"connectTime"]) {
        return  [self.formatter stringFromDate:client.connectTime];
    }
    if ([tableColumn.title isEqualToString:@"disconnectTime"]) {
        return [self.formatter stringFromDate:client.disconnectTime];
    }
    else
    {
        return nil;
    }
   
}

//手动跳转
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    //获取数据
    Client *client = self.moreArrsEntity[self.tableview.selectedRow];
    //手动跳转
    [self performSegueWithIdentifier:@"sendMessageVC" sender:client];
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(Client *)client
{
    //拿到目标控制器
       HMSendClientViewController *sendVC = segue.destinationController;
    //赋值参数
    sendVC.client = client;

}

@end
