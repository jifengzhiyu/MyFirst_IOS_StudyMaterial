//
//  TableViewController.m
//  01-UIPopoverController基本使用-(理解)
//
//  Created by apple on 16/3/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@"电影", @"电视剧", @"动画片"];
    
    // 设置popover的大小 --> 正确且合理的设置popover大小的方式
    //preferred: 优先的
    self.preferredContentSize = CGSizeMake(320 , self.dataArray.count * 44);
}


#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        
        // 绑定随机颜色 --> 点击cell将颜色传递给VC
        cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

#pragma mark cell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 获取cell颜色
    //cellForRowAtIndexPath:传入indexPath　--> 返回对应的cell
    UIColor *color = [tableView cellForRowAtIndexPath:indexPath].backgroundColor;
    
    //2. 传值block
    if (self.cellDidClick) {
        self.cellDidClick(color);
    }
}



@end
