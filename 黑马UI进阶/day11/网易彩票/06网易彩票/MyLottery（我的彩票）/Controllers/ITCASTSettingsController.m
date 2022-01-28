//
//  ITCASTSettingsController.m
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTSettingsController.h"
#import "ITCASTSettingsCell.h"
#import <MessageUI/MessageUI.h>

@interface ITCASTSettingsController ()
@property (nonatomic, strong) NSArray *groups;
@end

@implementation ITCASTSettingsController


- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}


// 懒加载plist数据到groups中
- (NSArray *)groups
{
    if (_groups == nil) {
        // 懒加载plist文件中的数据到_groups集合中
        NSString *path = [[NSBundle mainBundle] pathForResource:self.plistName ofType:nil];
        _groups = [NSArray arrayWithContentsOfFile:path];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 设置左侧的返回按钮为一张arrow图片
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackVc)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 2. 取消table view 的垂直滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    NSLog(@"%@", NSHomeDirectory());
    
}


- (void)goBackVc
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *groupDict = self.groups[section];
    return groupDict[@"header"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSDictionary *groupDict = self.groups[section];
    return groupDict[@"footer"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *groupDict = self.groups[section];
    NSArray *items = groupDict[@"items"];
    return items.count;
}




// 返回每一组的每一项对应的Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 获取数据
    NSDictionary *groupDict = self.groups[indexPath.section];
    NSDictionary *item = groupDict[@"items"][indexPath.row];
    
    
    // 2. 创建Cell
    ITCASTSettingsCell *cell = [ITCASTSettingsCell settingsCellWithTableView:tableView dict:item];
    
    
    // 3.1 把数据设置给cell
    // 把当前Cell对应的字典模型传递个自定义Cell
    cell.item = item;
    
    
    // 4. 返回Cell
    return cell;
}


// 选中某个Cell以后要执行的代码
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 每次选中某行以后, 立刻让这行变成非选中状态。
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *groupDict = self.groups[indexPath.section];
    NSDictionary *itemDict = groupDict[@"items"][indexPath.row];
    
    // 判断当前选中的cell是否有目标控制器
    if (itemDict[@"targetVcName"] && [itemDict[@"targetVcName"] length] > 0 ) {
        // 1. 获取目标控制器的类型
        Class targetClass = NSClassFromString(itemDict[@"targetVcName"]);
        // 2.1 创建目标控制器类型的对象
        UIViewController *targetVc = [[targetClass alloc] init];
        // 2.2 设置即将跳转的控制器的标题
        targetVc.navigationItem.title = itemDict[@"title"];
        
        // 2.3 判断目标控制器是否是一个设置控制器, 如果是设置控制器, 那么才需要加载对应的plist文件
        if ([targetVc isKindOfClass:[ITCASTSettingsController class]]) {
            // 1. 加载plist文件名
            NSString *plistName = itemDict[@"plistName"];
            
            // 2. 设置当前控制器要加载的plist文件
            ITCASTSettingsController *settingVc1 = (ITCASTSettingsController *)targetVc;
            // 设置plist文件给对应的目标控制器
            settingVc1.plistName = plistName;
        }
        
        // 3. 把目标控制器push到导航控制器中
        [self.navigationController pushViewController:targetVc animated:YES];
    }
    
    // 指定对应方法代码
    if (itemDict[@"funcName"] && [itemDict[@"funcName"] length] > 0) {
        // 调用这个方法
        SEL func = NSSelectorFromString(itemDict[@"funcName"]);
        
        // 调用一下func这个方法
        if ([self respondsToSelector:func]) {
# pragma clang diagnostic push
# pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:func];
# pragma clang diagnostic pop
        }
        
    }
}


// 检查新版本
- (void)checkUpdate
{
    //NSLog(@"您已经是最新版本了。。。");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作提示" message:@"已经是最新版本！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


// 评分支持
- (void)comment
{
    // 跳转到当前应用程序的app store的位置
    NSString *strUrl = @"https://itunes.apple.com/cn/app/id411654863?mt=8";
    NSURL *url = [NSURL URLWithString:strUrl];
    
    // 跳转到苹果的应用商店
    UIApplication *app = [UIApplication sharedApplication];
    [app openURL:url];
}


// 打电话
- (void)callService
{
//    NSIndexPath *idxPath = [self.tableView indexPathForSelectedRow];
//    NSDictionary *groupDict = self.groups[idxPath.section];
//    NSDictionary *itemDict = groupDict[@"items"][idxPath.row];
//    
//    // 获取电话号码
//    NSString *number = itemDict[@"details"];
//    
//    //--- 打电话 --
//    // 1. 创建一个电话的url
//    NSString *strUrl = [NSString stringWithFormat:@"tel://%@", number];
//    NSURL *url = [NSURL URLWithString:strUrl];
//    
//    // 2. 打开这个url
//    [[UIApplication sharedApplication] openURL:url];
    
    
    
    
    
//    // 获取电话号码
//    
//    
//    //--- 打电话 --
//    // 1. 创建一个电话的url
//    NSString *strUrl = [NSString stringWithFormat:@"sms://15230628185"];
//    NSURL *url = [NSURL URLWithString:strUrl];
//    
//    // 2. 打开这个url
//    [[UIApplication sharedApplication] openURL:url];
    
    //------------------------------------------------------
    MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc] init];
    // 设置短信内容
    vc.body = @"吃饭了没？";
    // 设置收件人列表
    vc.recipients = @[@"15230628185", @"13598045526"];
    // 设置代理
    //vc.messageComposeDelegate = self;
    
    // 显示控制器
    [self presentViewController:vc animated:YES completion:nil];

}

@end














