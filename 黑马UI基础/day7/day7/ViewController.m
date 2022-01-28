//
//  ViewController.m
//  day7
//
//  Created by 翟佳阳 on 2021/9/14.
//

#import "ViewController.h"
#import "JFGoods.h"
#import "JFGoodsCell.h"
#import "JFFooterView.h"
#import "JFHeaderView.h"

@interface ViewController ()<UITableViewDataSource,JFFooterViewDelegate>
@property(nonatomic,strong)NSMutableArray * goods;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ViewController


#pragma mark - 懒加载数据
- (NSMutableArray *)goods{
    if(_goods == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tuanGou.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            JFGoods *model = [JFGoods goodsWithDict:dict];
            [arrayModels addObject:model];
        }
        _goods = arrayModels;
    }
    return _goods;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1、获取模型数据
    JFGoods *model = self.goods[indexPath.row];
    //2、创建单元格
    {
//        static NSString *ID = @"goods_cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//
//    }
    }
    //通过xib的方式创建单元格，对单元格进行重用
    //把它封装一下，解耦；写的代码少，方便
    {
//        static NSString *ID = @"goods_cell";
//    JFGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if(cell == nil){
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"JFGoodsCell" owner:nil options:nil] firstObject];
//    }
    }
        //代码没有设置id，但是在xib文件里面可以设置id
    
    
    //3、把模型数据设置给单元格
        
    {
//        cell.imageView.image = [UIImage imageNamed:model.icon];
//        cell.textLabel.text = model.title;
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %@        %@人已购买",model.price,model.buyCount];
    }
    JFGoodsCell * cell = [JFGoodsCell goodsCellWithTableView:tableView];
    
    cell.goods = model;
    
    
    return cell;
}


# pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[_tableView registerClass:JFoodsCell.class forCellReuseIdentifier:@"goods_cell"];
    self.tableView.rowHeight = 44;
    
    //设置UITableView的footerView
    {
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    btn.backgroundColor = [UIColor systemPinkColor];
//    btn.frame = CGRectMake(50, 60, 70, 80);
//    //证明UITableView的footerView：只能修改X,H的值
//    self.tableView.tableFooterView = btn;
    }
    //使用xib的方法来加载footerView
//    JFFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"JFFooterView" owner:nil options:nil] lastObject];
    //将其封装
    JFFooterView *footerView = [JFFooterView footerView];              
    
    //设置footerView的代理,是当前控制器
    footerView.delegate = self;
    
    self.tableView.tableFooterView = footerView;
    
    //创建headerView
    
    JFHeaderView *headerView = [JFHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    
}

#pragma mark - JFFooterView的代理方法
- (void)footerViewUpdateData:(JFFooterView *)footerView{
    //增加一条数据
    //1、创建一个模型对象
    JFGoods *model = [[JFGoods alloc] init];
    model.title = @"哈哈哈";
    model.price = @"333";
    model.icon = @"25";
    //2、把模型对象加到控制器的goods集合中
    [self.goods addObject:model];
    //3、刷新UITableView
    [self.tableView reloadData];
    
    //把指定的行，滚到能滚的最上面
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.goods.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


@end
