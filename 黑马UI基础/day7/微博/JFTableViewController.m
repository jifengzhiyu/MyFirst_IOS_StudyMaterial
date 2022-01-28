//
//  JFTableViewController.m
//  微博
//
//  Created by 翟佳阳 on 2021/9/15.
//

#import "JFTableViewController.h"
#import "JFWeibo.h"
#import "JFWeiboCell.h"
#import "JFWeiboFrame.h"
@interface JFTableViewController ()
@property(nonatomic,strong)NSArray * weiboFrames;


@end

@implementation JFTableViewController
 
# pragma mark - 懒加载(把控件的frame也加载出来）

- (NSArray *)weiboFrames{
    if(_weiboFrames == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"weibos.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        for (NSDictionary *dict in arrayDict) {
            //创建一个数据模型
            JFWeibo *model = [JFWeibo weiboWithDict:dict];
            //创建一个frame模型
            //创建一个空的frame模型
            JFWeiboFrame *modelFrame = [[JFWeiboFrame alloc] init];
            //把数据模型给frame模型
            modelFrame.weibo = model;
            
            [arrayModels addObject:modelFrame];
        }
        _weiboFrames = arrayModels;
    }
    return _weiboFrames;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weiboFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1、获取模型数据
    JFWeiboFrame *model = self.weiboFrames[indexPath.row];
    //2、创建单元格
    JFWeiboCell *cell = [JFWeiboCell weiboCellWithTableView:tableView];
    //3、设置单元格数据
    cell.weiboFrame = model;
    //4、返回单元格
    return cell;
    
}

#pragma mark - 代理方法

///返回每行行高的方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JFWeiboFrame *weiboFrame = self.weiboFrames[indexPath.row];
    return weiboFrame.rowHeight;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
 

@end
