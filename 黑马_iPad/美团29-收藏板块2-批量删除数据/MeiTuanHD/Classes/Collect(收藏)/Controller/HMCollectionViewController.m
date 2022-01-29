//
//  HMCollectionViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMCollectionViewController.h"
#import "HMDealCell.h"
#import "HMDealModel.h"
#import "HMDetailViewController.h"
#import "HMDealTool.h"

@interface HMCollectionViewController ()

/** 页码*/
@property (nonatomic, assign) NSInteger currentPage;
/** 团购数据数组*/
@property (nonatomic, strong) NSMutableArray *dealArray;
/** 请求无数据图像*/
@property (nonatomic, strong) UIImageView *noDataImageView;

/** 返回 item*/
@property (nonatomic, strong) UIBarButtonItem *backItem;
/** 全选 item*/
@property (nonatomic, strong) UIBarButtonItem *selectAllItem;
/** 全不选 item*/
@property (nonatomic, strong) UIBarButtonItem *unSelectAllItem;
/** 删除 item*/
@property (nonatomic, strong) UIBarButtonItem *deleteItem;

@end

@implementation HMCollectionViewController

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
    
    //1. 获取列数
    NSInteger col = size.width > size.height == YES ? 3 : 2;
    
    //2. 获取 layout
    UICollectionViewFlowLayout *laytout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    //3. 计算间距
    // (width - col * cell.width) / (col + 1)
    CGFloat inset = (size.width - col * laytout.itemSize.width) / (col + 1);
    
    //4. 设置间距
    laytout.sectionInset = UIEdgeInsetsMake(inset, inset , inset, inset);
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
    
    // 设置导航栏
    self.title = @"收藏板块";
    
    self.navigationItem.leftBarButtonItems = @[self.backItem];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonItemClick:)];
    
    // 已进入当前板块就加载第一页的数据
    self.currentPage = 0;
    [self loadMoreDeal];
//    self.currentPage = 1;
//    
//    [self.dealArray addObjectsFromArray:[HMDealTool collectDealModelWithPage:self.currentPage]];
//    
//    [self.collectionView reloadData];
}

#pragma mark - 导航栏按钮点击的方法
#pragma mark 编辑按钮点击
- (void)editButtonItemClick:(UIBarButtonItem *)item
{
    
    if ([item.title isEqualToString:@"编辑"]) {
        //1. 根据按钮文字来改变文字
        item.title = @"完成";
        
        //2. 导航栏左边按钮的控制
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.selectAllItem, self.unSelectAllItem, self.deleteItem];
    
        //3. MVC --> 更改模型数据 --> 刷新界面 --> view 就会发生改变
        for (HMDealModel *dealModel in self.dealArray) {
            // YES --> 那么刷新界面就可以改变按钮的显示
            dealModel.editting = YES;
        };
        
    } else {
        //1. 根据按钮文字来改变文字
        item.title = @"编辑";
        
        //2. 导航栏左边按钮的控
        self.navigationItem.leftBarButtonItems = @[self.backItem];
        
        //3. MVC --> 更改模型数据 --> 刷新界面 --> view 就会发生改变
        for (HMDealModel *dealModel in self.dealArray) {
            // YES --> 那么刷新界面就可以改变按钮的显示
            dealModel.editting = NO;
            dealModel.choose = NO;
        };
        
        }
    
    //4. 刷新界面
    [self.collectionView reloadData];
    
}

#pragma mark 全选按钮
- (void)selectAllItemClick
{
    //1. 遍历数据
    for (HMDealModel *dealModel in self.dealArray) {
        dealModel.choose = YES;
    }
    
    //2. 刷新数据
    [self.collectionView reloadData];
    
    //3. 删除按钮设置
    self.deleteItem.enabled = YES;
}

#pragma mark 全不选按钮
- (void)unSelectAllItemClick
{
    //1. 遍历数据
    for (HMDealModel *dealModel in self.dealArray) {
        dealModel.choose = NO;
    }
    
    //2. 刷新数据
    [self.collectionView reloadData];
    
    
    //3. 删除按钮设置
    self.deleteItem.enabled = NO;
}

#pragma mark 删除选按钮
- (void)deleteItemClick
{
    //0. 临时数组记录要删除的数据
    NSMutableArray *tempArray = [NSMutableArray array];
    
    //1. 遍历数据
    for (HMDealModel *dealModel in self.dealArray) {
        //was mutated while being enumerated.'
        //不能再遍历可变数据的时候, 对数据进行更改. 在遍历完成才可以

        // 如果打钩为 YES, 就代表要删除数据
        if (dealModel.choose) {
            
            //2.1 记录要删除的数据
            [tempArray addObject:dealModel];
            
            //2.2 要删除数据库的数据
            [HMDealTool removeCollectDeal:dealModel];
            
        }
    }
    
    //3. 删除数据
    [self.dealArray removeObjectsInArray:tempArray];
    
    //4. 刷新数据
    [self.collectionView reloadData];
    
    //5. 删除按钮设置
    self.deleteItem.enabled = NO;
}

#pragma mark - 添加刷新功能
- (void)setupRefresh
{
    //1. 添加上拉加载
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDeal];
    }];
    
    //2. 一开始就隐藏底部刷新
    self.collectionView.mj_footer.hidden = YES;
}


#pragma mark - 网络请求
#pragma mark 加载更多数据
- (void)loadMoreDeal
{
    //1. 页码保持自增
    self.currentPage++;
    
    //2. 调用工具类方法
    [self.dealArray addObjectsFromArray:[HMDealTool collectDealModelWithPage:self.currentPage]];
    
    //3. 刷新表格
    [self.collectionView reloadData];
    
    //4. 停止刷新
    [self.collectionView.mj_footer endRefreshing];

}


#pragma mark - UICollectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //5. 控制底部刷新控件的显示与隐藏
    // 获取本地数据库的总个数  == self.dealArray.count 相等就代表没有数据了
    self.collectionView.mj_footer.hidden = [HMDealTool totalCount] == self.dealArray.count;
    
    //6. 没有数据的时候, 显示无数据图像
    // hidden ? 有数据的时候就隐藏 --> self.dealArray.count != 0
    self.noDataImageView.hidden = self.dealArray.count != 0;
    
    NSLog(@"count: %zd",self.dealArray.count);
    return self.dealArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HMDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.dealModel = self.dealArray[indexPath.row];
    
    //设置 block 回调
    cell.dealCellDidClickBlock = ^ () {
        // 只要接受到了回调, 那么就遍历数据, 如果发现有任何1个cell 被打钩了, 那么就恢复删除按钮的可用 --> 循环不需要完全执行
        
        //1. 打钩的标识符
        BOOL isChoose = NO;
        
        //2. 遍历
        for (HMDealModel *dealModel in self.dealArray) {
            
            //3. 判断是否打钩了
            if (dealModel.choose) {
                //如果有任何一个打钩了,就标识一下
                isChoose = YES;
                //4. 此处可以跳出循环
                break;
            }
        }
        
        //5.恢复删除按钮的可用
        self.deleteItem.enabled = isChoose;
    };
    
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMDetailViewController *detailVC = [HMDetailViewController new];
    detailVC.dealModel = self.dealArray[indexPath.row];
    
    detailVC.detailVCCollectClick = ^() {
        //1. 页码归零
        self.currentPage = 0;
        
        //2. 删除之前的数据
        [self.dealArray removeAllObjects];
        
        //3. 重新获取数据
        [self loadMoreDeal];
    };
    
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
        _noDataImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_collects_empty"]];
        
        //2. 添加到 view 中
        [self.collectionView addSubview:_noDataImageView];
        
        //3. 布局
        [_noDataImageView autoCenterInSuperview];
    }
    return _noDataImageView;
}

- (UIBarButtonItem *)backItem
{
    if (_backItem == nil) {
        _backItem = [UIBarButtonItem barBuutonItemWithTarget:self action:@selector(backButtonClick) icon:@"icon_back" highlighticon:@"icon_back_highlighted"];
    }
    return _backItem;
}

- (UIBarButtonItem *)selectAllItem
{
    if (_selectAllItem == nil) {
        _selectAllItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllItemClick)];
    }
    return _selectAllItem;
}

- (UIBarButtonItem *)unSelectAllItem
{
    if (_unSelectAllItem == nil) {
        _unSelectAllItem = [[UIBarButtonItem alloc] initWithTitle:@"全不选" style:UIBarButtonItemStylePlain target:self action:@selector(unSelectAllItemClick)];
    }
    return _unSelectAllItem;
}

- (UIBarButtonItem *)deleteItem
{
    if (_deleteItem == nil) {
        _deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteItemClick)];
        
        // 删除按钮一开始就是失效状态
        _deleteItem.enabled = NO;
    }
    return _deleteItem;
}

#pragma mark 返回按钮
- (void)backButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
