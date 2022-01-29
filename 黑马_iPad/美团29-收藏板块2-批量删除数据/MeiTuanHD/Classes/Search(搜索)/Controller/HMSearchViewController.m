//
//  HMSearchViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMSearchViewController.h"

@interface HMSearchViewController ()<UISearchBarDelegate>

@end

@implementation HMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 导航栏
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barBuutonItemWithTarget:self action:@selector(backButtonClick) icon:@"icon_back" highlighticon:@"icon_back_highlighted"];
    
    // 设置搜索框
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.placeholder = @"请输入搜索内容";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
}

/**
 监听搜索框的搜索按钮点击
 点击时应该发送请求: city keyword
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 框架的刷新方法
    [self.collectionView.mj_header beginRefreshing];
    
    [searchBar resignFirstResponder];
}

- (void)setParams:(NSMutableDictionary *)params
{
    params[@"city"] = self.selectCity;
    
    // 通过导航栏的 titleView 直接获取一个 searchBar
    UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    params[@"keyword"] = searchBar.text;
}

#pragma mark 返回按钮
- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
