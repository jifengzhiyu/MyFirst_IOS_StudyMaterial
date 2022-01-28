//
//  ITCASTHelpListController.m
//  06网易彩票
//
//  Created by teacher on 15/7/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTHelpListController.h"
#import "ITCASTHelp.h"
#import "ITCASTHelpCell.h"
#import "ITCASTWebController.h"

@interface ITCASTHelpListController ()

@property (nonatomic, strong) NSArray *helpList;
@end

@implementation ITCASTHelpListController

- (NSArray *)helpList
{
    if (_helpList == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        NSArray *arrayDicts = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDicts) {
            ITCASTHelp *model = [ITCASTHelp helpWithDict:dict];
            [arrayModels addObject:model];
        }
        _helpList = arrayModels;
    }
    return _helpList;
}

#pragma mark - 数据源方法
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.helpList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 获取模型数据
    ITCASTHelp *model = self.helpList[indexPath.row];
    
    // 2. 创建cell
    ITCASTHelpCell *cell = [ITCASTHelpCell helpCellWithTableView:tableView];
    
    // 3. 把模型数据设置给Cell
    cell.help = model;
    
    // 4. 返回Cell
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 先获取当前选中行对应的模型对象
    ITCASTHelp *model = self.helpList[indexPath.row];
    
    // 2. 创建目标控制器, 并且执行跳转
    // 2.1 创建一个目标控制器
    ITCASTWebController *wbVc = [[ITCASTWebController alloc] init];
    wbVc.help = model;
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:wbVc];
    
    // 2.2 执行跳转(通过modal的方式跳转)
    [self presentViewController:navVc animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.navigationItem.title = @"常见问题";
}
@end









