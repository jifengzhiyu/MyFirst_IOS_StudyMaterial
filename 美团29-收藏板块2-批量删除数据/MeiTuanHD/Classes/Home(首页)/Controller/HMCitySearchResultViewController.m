//
//  HMCitySearchResultViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMCitySearchResultViewController.h"
#import "HMCityModel.h"

@interface HMCitySearchResultViewController ()

/** 所有的城市数据*/
@property (nonatomic, strong) NSMutableArray *cityArray;

/** 结果数据数组*/
@property (nonatomic, strong) NSMutableArray *resultArray;

@end

@implementation HMCitySearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cityArray = [NSMutableArray array];
    self.resultArray = [NSMutableArray array];
    
    NSArray *cityPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil]];
    
    for (NSDictionary *dict in cityPlist) {
        [self.cityArray addObject:[HMCityModel yy_modelWithJSON:dict]];
    }
    
}

#pragma mark 重写搜索文字的 set 方法 
- (void)setSearchText:(NSString *)searchText
{
    //1. copy
    _searchText = [searchText copy];
    
    //2. 转换小写
    searchText = searchText.lowercaseString;
    
    //3. 删除之前的数据
    [self.resultArray removeAllObjects];
    
    //4. 遍历数据
    for (HMCityModel *cityModel in self.cityArray) {
        // 判断中文是否包含, 全拼, 以及首字母缩写是否包含
        if ([cityModel.name containsString:searchText] || [cityModel.pinYin containsString:searchText] || [cityModel.pinYinHead containsString:searchText]) {
            
            //5. 添加数据到结果中
            [self.resultArray addObject:cityModel.name];
        }
    }
    
    //6. 刷新表格
    [self.tableView reloadData];
    
}

#pragma mark - TableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.resultArray[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共有%ld个结果", self.resultArray.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1. 发送通知
    [HMNotificationCenter postNotificationName:HMCityDidChangeNotifacation object:nil userInfo:@{HMSelectCityName: self.resultArray[indexPath.row]}];
    
    //2. 消失控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
