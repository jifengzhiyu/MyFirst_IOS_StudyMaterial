//
//  ViewController.m
//  day6
//
//  Created by 翟佳阳 on 2021/9/11.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

//1、optional方法，设定分组，默认一组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//2、告诉UITableView每组显示几条数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}

//3、告诉UITableView每一组的每一行单元格显示什么内容
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //indexPath封装了section和row
    //创建一个单元格对象并返回
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    //为单元格指定数据,单元格里面已经存在许多控件了
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            cell.textLabel.text = @"riben";
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"hanguo";
        }else{
            cell.textLabel.text = @"zhongguo";
        }
    }else if (indexPath.section == 1){
        if(indexPath.row == 0){
            cell.textLabel.text = @"xila";
        }else{
            cell.textLabel.text = @"aba";
        }
    }else{
        cell.textLabel.text = @"aiji";
    }
    return cell;
}

//根据索引section，返回不同的组标题
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"亚洲";
    }else if (section == 1){
        return @"欧洲";
    }else{
        return @"非洲";
    }
}

//根据section,组尾返回不同描述信息
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(section == 0){
        return @"想住";
    }else if (section == 1){
        return @"想去";
    }else {
        return @"快逃";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //输出控制器管理view的大小
    //NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    //设置数据源对象
    self.tableView.dataSource = self;
}


@end
