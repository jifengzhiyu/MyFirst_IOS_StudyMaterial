//
//  ITCASTGuideController.m
//  06网易彩票
//
//  Created by teacher on 15/7/17.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTGuideController.h"
#import "ITCASTGuideCell.h"
#import "UIView+ITCASTExt.h"
#define ITCASTCELLCount 4

@interface ITCASTGuideController ()
@property (nonatomic, weak) UIImageView *imgView1;
@property (nonatomic, weak) UIImageView *imgLargeText;
@property (nonatomic, weak) UIImageView *imgSmallText;

@end

@implementation ITCASTGuideController

static NSString * const reuseIdentifier = @"guide_cell";


- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    // 设置collection view的滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:flowLayout];
}

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:flowLayout];
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ITCASTCELLCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 获取数据
    NSString *imgName = [NSString stringWithFormat:@"guide%@Background", @(indexPath.row + 1)];
    
    // 2. 创建Cell
    ITCASTGuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 3. 把数据赋值给cell
    //cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:0.7];
    cell.image = [UIImage imageNamed:imgName];
    
    [cell setIndexPath:indexPath withCellCount:ITCASTCELLCount];
    
    // 4. 返回cell
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册cell
    [self.collectionView registerClass:[ITCASTGuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 进制滚动时候的弹簧效果
    self.collectionView.bounces = NO;
    // 禁用水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 开启分页
    self.collectionView.pagingEnabled = YES;
    
    
    
    //------------ 添加图片到UICollectionView中 -------------------
    // 1. "足球、篮球"图片
    UIImageView *imgView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    [self.collectionView addSubview:imgView1];
    self.imgView1 = imgView1;
    
    // 2. "波浪线"图片
    UIImageView *imgLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    imgLine.x = -202;
    [self.collectionView addSubview:imgLine];

    
    
    // 3. "大文字"图片
    UIImageView *imgLargeText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    imgLargeText.y =  [UIScreen mainScreen].bounds.size.height * 0.7;
    [self.collectionView addSubview:imgLargeText];
    self.imgLargeText = imgLargeText;
    
    
    // 4. "小文字"图片
    UIImageView *imgSmallText = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    imgSmallText.y = [UIScreen mainScreen].bounds.size.height * 0.8;
    [self.collectionView addSubview:imgSmallText];
    self.imgSmallText = imgSmallText;
}

// Scroll View 滚动结束事件（滚动已经减速完成）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //NSLog(@"--------%@-------------", NSStringFromCGRect(scrollView.bounds));
    // 1. 获取滚动偏移的x值
    CGFloat offsetX = scrollView.contentOffset.x;

    // 获取当前要显示的下一张图片的名称
    int page = offsetX / scrollView.bounds.size.width;
    
    
    // 把图片名称设置给图片框
    NSString *guide = [NSString stringWithFormat:@"guide%d", (page + 1)];
    NSString *largeText = [NSString stringWithFormat:@"guideLargeText%d", (page + 1)];
    NSString *smallText = [NSString stringWithFormat:@"guideSmallText%d", (page + 1)];
    
    self.imgView1.image = [UIImage imageNamed:guide];
    self.imgLargeText.image = [UIImage imageNamed:largeText];
    self.imgSmallText.image = [UIImage imageNamed:smallText];
    
    
    
    // 判断滚动方向（向左滚还是向右滚动）
    CGFloat startX = offsetX;
    if (offsetX > self.imgView1.x) {
        // 向左滚
        startX = offsetX + scrollView.bounds.size.width;
    } else if (offsetX < self.imgView1.x) {
        //向右滚动
        startX = offsetX - scrollView.bounds.size.width;
    }
    // 根据向左滚动还是向右滚动，先设置一下每个图片框的起始x值
    self.imgView1.x = startX;
    self.imgLargeText.x = startX;
    self.imgSmallText.x = startX;
    
    
    
    // 2. 设置那几个图片框的x值等于滚动偏移的x值
    [UIView animateWithDuration:1.0 animations:^{
        self.imgView1.x = offsetX;
        self.imgLargeText.x = offsetX;
        self.imgSmallText.x = offsetX;
    }];
    
}
@end

















