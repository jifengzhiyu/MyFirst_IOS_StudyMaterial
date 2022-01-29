//
//  HMCategoryViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMCategoryViewController.h"
#import "HMDropDownView.h"
#import "HMCategoryModel.h"
#import "HMMateTool.h"

@interface HMCategoryViewController ()

@end

@implementation HMCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 创建下拉菜单
    HMDropdownView *dropdownView = [HMDropdownView dropDownView];
    
    //2. 添加到视图上
    [self.view addSubview:dropdownView];
    
    //3. 设置大小 --> 内容控制器
    self.preferredContentSize = dropdownView.size;
    
    //4. 加载数据, 传递给下拉菜单
//    NSArray *categoryArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil]];
//    
//    NSMutableArray *tempArray = [NSMutableArray array];
//    for (NSDictionary *dict in categoryArray) {
//        [tempArray addObject:[HMCategoryModel yy_modelWithJSON:dict]];
//    }
    
    dropdownView.categoryArray = [HMMateTool categories];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
