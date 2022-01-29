//
//  JFAppTableViewController.m
//  3自定义模版_应用管理
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import "JFAppTableViewController.h"
#import "JFApp.h"
#import "JFAppCell.h"
@interface JFAppTableViewController ()<JFAppCellDelegate>
@property (nonatomic, copy)NSArray *apps;
@end

@implementation JFAppTableViewController
#pragma mark - 懒加载
- (NSArray *)apps{
    if(_apps == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
        NSArray *arrayDicts = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDicts) {
            JFApp *model = [JFApp AppWithDict:dict];
            [arrayModels addObject:model];
        }
        _apps = arrayModels;
    }
    return _apps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 120;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取模型数据
    JFApp *model = self.apps[indexPath.row];
    
    //通过stroyboard中的cell模版加载单元格
    static NSString *ID = @"app_cell";
    JFAppCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //设置单元格的代理
    cell.delegate = self;
    //把模型设置给单元格
    cell.app = model;
    
    
    return cell;
}

#pragma mark - JFAppCell的代理方法
- (void)appCellDidClickDownloadButton:(JFAppCell *)appCell{
    //1、创建一个lable
    UILabel *lblMsg = [[UILabel alloc] init];
    //2、设置文字
    lblMsg.text = @"正在下载，，，";
    lblMsg.backgroundColor = [UIColor blackColor];
    lblMsg.textColor = [UIColor redColor];
    //更改文字大小
    lblMsg.font = [UIFont systemFontOfSize:16];
    CGFloat msgW = 200;
    CGFloat msgH = 40;
    CGFloat msgX = (self.view.frame.size.width - msgW) * 0.5;
    CGFloat msgY = (self.view.frame.size.height - msgH) *0.5;
    //设置文字居中对齐
    lblMsg.textAlignment = NSTextAlignmentCenter;
//    设置lbl透明度
    lblMsg.alpha = 0.6;
    //设置lable圆角显示
    lblMsg.layer.cornerRadius = 10;
    lblMsg.layer.masksToBounds = YES;
    //3、设置frame
    lblMsg.frame = CGRectMake(msgX, msgY, msgW, msgH);
    
    //当前属于tableView控制器，弹窗会随着tableView滚动
    //[self.view addSubview:lblMsg];
    UIWindow *window =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
      [window addSubview:lblMsg];

    //4、通过动画的方式慢慢显示lable
    [UIView animateWithDuration:1.0 animations:^{
        //执行动画方法
        lblMsg.alpha = 0.6;
    } completion:^(BOOL finished) {
        //延迟一段时间，消退颜色
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            lblMsg.alpha = 0;
        } completion:^(BOOL finished) {
            //整个动画结束。移除lable
            [lblMsg removeFromSuperview];
        }];
    }];
    
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

@end
