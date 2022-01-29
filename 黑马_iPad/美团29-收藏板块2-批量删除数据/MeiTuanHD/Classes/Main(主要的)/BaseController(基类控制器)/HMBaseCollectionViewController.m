//
//  HMBaseCollectionViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMBaseCollectionViewController.h"
#import "HMDealCell.h"
#import "HMDealModel.h"
#import "HMDetailViewController.h"


@interface HMBaseCollectionViewController ()<DPRequestDelegate>

/** 页码*/
@property (nonatomic, assign) NSInteger currentPage;
/** 团购数据数组*/
@property (nonatomic, strong) NSMutableArray *dealArray;
/** 最后一次请求*/
@property (nonatomic, strong) DPRequest *lastRequest;
/** 请求无数据图像*/
@property (nonatomic, strong) UIImageView *noDataImageView;

@end

@implementation HMBaseCollectionViewController

#pragma mark 重写 init 方法设置布局

- (instancetype)init
{
    self = [super init];
    if (self) {
        //1. 创建布局
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        // 设置大小
        layout.itemSize = CGSizeMake(305, 305);
        
        // 设置间距  --> 屏幕旋转的时候在计算
        //        layout.sectionInset = UIEdgeInsetsMake(50, 50, 50, 50);
        //        layout.minimumLineSpacing = 50;
        
        //2. 设置 self 的布局
        self = [self initWithCollectionViewLayout:layout];
        
    }
    return self;
}

#pragma mark 屏幕旋转方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    
    //    NSInteger col = 0;
    //    if (size.width > size.height) {
    //        col = 3;
    //    } else {
    //        col = 2;
    //    }
    
    //1. 获取列数
    NSInteger col = size.width > size.height == YES ? 3 : 2;
    
    //2. 获取 layout
    UICollectionViewFlowLayout *laytout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    //3. 计算间距
    // (width - col * cell.width) / (col + 1)
    CGFloat inset = (size.width - col * laytout.itemSize.width) / (col + 1);
    
    //4. 设置间距
    laytout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    laytout.minimumLineSpacing = inset;
}

/**
 1. 修改重用标识符 --> cell 设置一个
 2. 注册 cell
 3. 设置 cell 的大小
 4. 修改 cell 的类
 */
static NSString * const reuseIdentifier = @"dealCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 主动调用屏幕旋转方法
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:self.transitionCoordinator];
    
    self.collectionView.backgroundColor = HMGlobalColor;
    
    // 注册 cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"HMDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    // 添加刷新功能
    [self setupRefresh];
}
#pragma mark - 添加刷新功能
- (void)setupRefresh
{
    //1. 添加下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewDeal];
    }];
    
//    if (self.needFirstFefresh) {
        //2. 一开始就刷新 : 进入刷新状态 --> 就会自动调用上方 block 绑定的方法
//        [self.collectionView.mj_header beginRefreshing];
//    }
    
    //3. 添加上拉加载
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDeal];
    }];
    
    //4. 一开始就隐藏底部刷新
    self.collectionView.mj_footer.hidden = YES;
    
}

#pragma mark - 网络请求
#pragma mark 加载新数据
- (void)loadNewDeal
{
    //1. 页码永远保持1
    self.currentPage = 1;
    
    //2. 调用加载方法
    [self loadDeal];
}
#pragma mark 加载更多数据
- (void)loadMoreDeal
{
    //1. 页码保持指正
    self.currentPage++;
    
    //2. 调用加载方法
    [self loadDeal];
}

#pragma mark 加载数据公用方法
- (void)loadDeal
{
    //1. 创建 DPAPI
    DPAPI *api = [DPAPI new];
    
    //2. 拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 调用设置参数的方法
    // homeVC --> 需要发送网络请求的时候, 就会调用下面的方法
    // 如果是子类调用父类中的方法, 那么会先从子类中查找此方法, 如果子类没有实现, 才会去找父类的方法
    // 思考: 如果父类也实现了此方法, 会对结果又影响么? 没有
    
    [self setParams:params];
    
    //2.5 限制
    params[@"limit"] = @(20);
    
    //2.6 页码
    params[@"page"] = @(self.currentPage);
    
    //3. 发送请求
    self.lastRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
    //NSLog(@"params %@", params);
    //    //4. 加载进度指示器
    //    [SVProgressHUD showWithStatus:@"正在玩命加载中..." maskType:SVProgressHUDMaskTypeBlack];
}

#pragma mark 请求成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //NSLog(@"resutl:%@", result);
    
    /**
     屏蔽多余请求
     1. 加载进度指示器: 缺点: 阻碍用户交 优点: 省流量
     2. 记录最后一次请求 : 缺点: 浪费流量 优点: 不会阻碍用户交互
     */
    //1. 取消进度指示器
    //    [SVProgressHUD dismiss];
    //1. 判断是否是最后一次请求
    if (request != self.lastRequest) {
        return;
    }
    
    //2. 获取数据
    //2.1 如果是加载新数据, 需要把之前的数据清空
    if (self.currentPage == 1) {
        [self.dealArray removeAllObjects];
    }
    
    //2.2 拼接新的数据
    for (NSDictionary *dict in result[@"deals"]) {
        [self.dealArray addObject:[HMDealModel yy_modelWithJSON:dict]];
    }
    
    //2.3 获取团购总数
    NSInteger totalCount = [result[@"total_count"] integerValue];
    
    //3. 停止刷新控件
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    
    
    //4. 刷新表格
    [self.collectionView reloadData];
    
    //5. 控制底部刷新控件的显示与隐藏
    // hidden = YES : 服务器没有数据可以显示
    // 获取服务器返回的总数  == self.dealArray.count 相等就代表没有数据了. Hidden
    self.collectionView.mj_footer.hidden = totalCount  == self.dealArray.count;
    
    //6. 没有数据的时候, 显示无数据图像
    // hidden ? 有数据的时候就隐藏 --> self.dealArray.count != 0
    self.noDataImageView.hidden = self.dealArray.count != 0;
}

#pragma mark 请求失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    //1. 取消进度指示器
    //    [SVProgressHUD dismiss];
    //1. 判断是否是最后一次请求
    if (request != self.lastRequest) {
        return;
    }
    
    //2. 停止刷新控件
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    
    //3. 提示用户加载失败 --> 进度指示器 / 显示无数据图像
    [SVProgressHUD showErrorWithStatus:@"请检查网络" maskType:SVProgressHUDMaskTypeBlack];
    
    //4. 页码自减
    if (self.currentPage > 1) {
        self.currentPage--;
    }
}


#pragma mark - UICollectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dealArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HMDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.dealModel = self.dealArray[indexPath.row];
    
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMDetailViewController *detailVC = [HMDetailViewController new];
    detailVC.dealModel = self.dealArray[indexPath.row];
    [self presentViewController:detailVC animated:YES completion:nil];
}


#pragma mark - 懒加载
- (NSMutableArray *)dealArray
{
    if (_dealArray == nil) {
        _dealArray = [NSMutableArray array];
    }
    return _dealArray;
}

- (UIImageView *)noDataImageView
{
    if (_noDataImageView == nil) {
        //1. 创建 imagView
        _noDataImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
        
        //2. 添加到 view 中
        [self.view addSubview:_noDataImageView];
        
        //3. 布局
        [_noDataImageView autoCenterInSuperview];
    }
    return _noDataImageView;
}

- (void)setParams:(NSMutableDictionary *)params
{
    NSLog(@"父类");
}

@end
