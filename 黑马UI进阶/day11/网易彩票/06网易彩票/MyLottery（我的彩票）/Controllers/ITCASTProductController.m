//
//  ITCASTProductController.m
//  06网易彩票
//
//  Created by teacher on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTProductController.h"
#import "ITCASTProduct.h"
#import "ITCASTProductCell.h"

@interface ITCASTProductController ()

// 用来保存模型的集合
@property (nonatomic, strong) NSArray *products;
@end

@implementation ITCASTProductController


// 单元格的可重用ID
static  NSString * const ID = @"product_cell";


- (NSArray *)products
{
    if (_products == nil) {
        // 1. 获取json文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"more_project.json" ofType:nil];
        
        // 2. 加载json文件
        // 2.1 先把json文件加载到一个NSData对象中
        NSData *dataJson = [NSData dataWithContentsOfFile:path];
        // 2.2 把NSData对象转换为一个字典的集合
        NSError *error = nil;
        NSArray *arrayDicts = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            // 出错了！！
            return nil;
        }
        
        
        // 2.3 字典转模型, 最终保存到一个模型的集合中
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDicts) {
            ITCASTProduct *model = [ITCASTProduct productWithDict:dict];
            [arrayModels addObject:model];
        }
        
        _products = arrayModels;
        
    }
    return _products;
}


// 重写init方法, 保证创建好的控制器就是一个"使用流式布局的控制器"
- (instancetype)init
{
    // 1. 创建一个流式布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 修改每个格子的大小
    flowLayout.itemSize = CGSizeMake(80, 80);
    // 修改每个格子和格子之间的（最小）水平间距
    flowLayout.minimumInteritemSpacing = 0;
    // 修改每行之间的行间距
    flowLayout.minimumLineSpacing = 20;
    // 设置每一组的距离四周的内边距
    flowLayout.sectionInset  = UIEdgeInsetsMake(10, 0, 0, 0);
    
    // 2. 返回
    return [super initWithCollectionViewLayout:flowLayout];
}

// 数据源方法
// 返回组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// 返回每组有多少个格子
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.products.count;
}

// 返回具体的每个格子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 获取数据
    ITCASTProduct *model = self.products[indexPath.row];
    
    // 2. 创建Cell
    ITCASTProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor redColor];
    
    // 3. 把数据设置给cell
    cell.product = model;
    
    // 4. 返回cell
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1. 获取当前用户选择的Cell对应的模型数据
    ITCASTProduct *product = self.products[indexPath.row];
    
    // 2. 拼接当前应用在手机中的地址
    NSString *strAppUrl = [NSString stringWithFormat:@"%@://%@", product.customUrl, product.ID];
    NSURL *urlAppUrl = [NSURL URLWithString:strAppUrl];
    
    // 应用程序在苹果商店的地址
    NSURL *urlAppStore = [NSURL URLWithString:product.url];
    
    // 3. 判断是否可以打开这个应用, 如果能打开则直接打开, 如果打不开则跳转到苹果应用
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:urlAppUrl]) {
        [app openURL:urlAppUrl];
    } else {
        [app openURL:urlAppStore];
    }
    
    
    //NSLog(@"%@", product.title);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 注册类：注册单元格：告诉系统(UICollectionView), 当缓存池中没有现成的cell对象以后，要创建哪个类的对象作为Cell来使用
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    // 注册xib：
    UINib *nib = [UINib nibWithNibName:@"ITCASTProductCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:ID];
    
    
    // 修改collection view的背景色
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
}
@end









