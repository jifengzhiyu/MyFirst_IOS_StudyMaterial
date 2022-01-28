//
//  ITCASTHallController.m
//  06网易彩票
//
//  Created by teacher on 15/7/14.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTHallController.h"

@interface ITCASTHallController ()
@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UIImageView *popImageView;
@end

@implementation ITCASTHallController


// 点击活动按钮
- (IBAction)buttonActivityClick:(UIButton *)sender {
    // 1. 创建一个半透明的的UIView
    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    
    // self.tabBarController表示获取当前控制器所在的UITabBarController
    [self.tabBarController.view addSubview:coverView];
    self.coverView = coverView;
    
    
    
    // 2. 创建一个中间显示的图片框
    // ** 注意：这里的popImageView不能添加到coverView中, 因为cover是"半透明的", 如果把popImageView添加到coverView中，那么popImageView也就变成半透明了。
    UIImageView *popImageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"showActivity"]];
    popImageView.center = self.tabBarController.view.center;
    popImageView.userInteractionEnabled = YES;
    [self.tabBarController.view addSubview:popImageView];
    self.popImageView = popImageView;

    
    // 3. 创建一个右侧的关闭按钮
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:@"alphaClose"] forState:UIControlStateNormal];
    CGFloat w = 19.5;
    CGFloat h = 19.5;
    CGFloat x = popImageView.bounds.size.width - w;
    CGFloat y = 0;
    button.frame = CGRectMake(x, y, w, h);
    [popImageView addSubview:button];
    [button addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

// 关闭按钮的单击事件
- (void)buttonCloseClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.coverView.alpha = 0;
        self.popImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.popImageView removeFromSuperview];
        [self.coverView removeFromSuperview];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *leftButton = self.navigationItem.leftBarButtonItem;
//    UIImage *imgActivity = [UIImage imageNamed:@"CS50_activity_image"];
//    
//    // 通过调用图片对象(UIImage对象)的imageWithRenderingMode:方法可以修改图片的渲染模式
//    imgActivity = [imgActivity imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    leftButton.image = imgActivity;
    
   // UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[UIButton alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
