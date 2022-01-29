//
//  JFQQFriendsTableViewController.m
//  2好友列表
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import "JFQQFriendsTableViewController.h"
#import "JFGroup.h"
#import "JFFriend.h"
#import "JFFriendCell.h"
#import "JFGroupHeaderView.h"
@interface JFQQFriendsTableViewController () <JFGroupHeaderViewDelegate>
@property (nonatomic, strong) NSArray *groups;
@end

@implementation JFQQFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 50;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - 懒加载
- (NSArray *)groups{
    if(_groups == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil];
        NSArray *arrayDicts = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDicts) {
            JFGroup *model = [JFGroup groupWithDict:dict];
            [arrayModels addObject:model];
        }
        _groups = arrayModels;
    }
    return _groups;
}

#pragma mark - JFGroupHeaderViewDelegate的代理方法
- (void)groupHeaderViewDidClickTitleButton:(JFGroupHeaderView *)groupHeaderView{
    //刷新tableView
    //[self.tableView reloadData];
    
    //局部刷新某一组
    NSIndexSet *idxSet = [NSIndexSet indexSetWithIndex:groupHeaderView.tag];
    [self.tableView reloadSections:idxSet withRowAnimation:UITableViewRowAnimationFade]
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    JFGroup *group = self.groups[section];
    if(group.isVisible){
        return group.friends.count;
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1、获取模型对象（数据）
    JFGroup *group = self.groups[indexPath.section];
    JFFriend *friend = group.friends[indexPath.row];
    //2、创建单元格（视图）
    JFFriendCell *cell = [JFFriendCell friendCellWithTableView:tableView];
    //3、设置单元格数据（把模型设置给单元格）
    cell.friendModel = friend;
    //4、返回单元格
    return cell;
}

///设置每一组的组标题,包含不了其他控件，不用这个方法
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    JFGroup *group = self.groups[section];
//    return group.name;
//}

///设置组标题
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //UITableViewHeaderFooterView继承UIView，可以重用UITableViewHeaderFooterView
    //1、获取模型数据
    JFGroup *group = self.groups[section];
    //2、创建UITableHeaderFooterView
    JFGroupHeaderView *headerVw = [JFGroupHeaderView groupHeaderViewWithTableView:tableView];
    headerVw.tag = section;
    //3、设置数据
    headerVw.group = group;
    //设置headerView的代理为当前控制器
    headerVw.delegate = self;
    
    //4、返回
    return headerVw;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
