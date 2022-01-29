//
//  HMNavAlpheTableViewController.m
//  导航栏渐变透明效果
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMNavAlpheTableViewController.h"
#import "UINavigationBar+suiyi.h"

@interface HMNavAlpheTableViewController ()

@end

@implementation HMNavAlpheTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"看我的颜色";
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];

//    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll %f",scrollView.contentOffset.y);
   CGFloat offsetY = scrollView.contentOffset.y;
    UIColor *color = [UIColor blueColor];
    
    
    if (offsetY > 30) {
        //透明
     CGFloat alphaset = (30 + 64 - offsetY)/ 64;
//        self.navigationController.navigationBar.alpha = alphaset;
        [self.navigationController.navigationBar navigationToAphle:[color colorWithAlphaComponent:alphaset]];
    }else
    {
        //显示
        
//        CGFloat alphaset = (30 + 64 - offsetY)/ 64;
        self.navigationController.navigationBar.alpha = 1;
        
    }

}

@end
