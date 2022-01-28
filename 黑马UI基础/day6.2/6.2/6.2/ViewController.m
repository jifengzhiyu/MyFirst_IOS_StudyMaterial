//
//  ViewController.m
//  6.2
//
//  Created by 翟佳阳 on 2021/9/12.
//

#import "ViewController.h"
#import "Hero.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray * heros;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController
//懒加载
-(NSArray*)heros{
    if(_heros == nil){
        NSString * path = [[NSBundle mainBundle] pathForResource:@"heros.plist" ofType:nil];
        NSArray * arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray * arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            Hero * model = [Hero heroWithDict:dict];
            [arrayModels addObject:model];
        }
        _heros = arrayModels;
    }
    return _heros ;
}

//数据源方法：
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.heros.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取模型数据
    Hero * model = self.heros[indexPath.row];
    //创建单元格
//    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    //使用单元格重用的方式
    //声明一个重用ID
     static NSString * ID = @"hero_cell";
    //根据重用ID去缓存池里面查找对应的cell,使用传进来的参数（数据源），也就是当前的tableView来找
     UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //判断，如果没有就重新创造一个单元格
    if(cell == nil){
        //创建一个新的单元格
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //设置单元格
    cell.imageView.image = [UIImage imageNamed:model.icom];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.intro;
    
    //右边显示一个小箭头,是单元格对象的一个属性（配件
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //统一设置单元格背景颜色
//    if(indexPath.row % 2 == 0){
//        cell.backgroundColor = [UIColor blueColor];
//    }else{
//        cell.backgroundColor = [UIColor yellowColor];
//    }
//
//    //设置单元格选中情况下的背景颜色
//    UIView * bgView = [[UIView alloc]init];
//    bgView.backgroundColor = [UIColor greenColor];
//    cell.selectedBackgroundView = bgView;

    //返回单元格
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //统一设置UITableView的所有行高,拖线
    //self.tableView.rowHeight = 80;
    
    
    //设置分割线的颜色
    self.tableView.separatorColor = [UIColor redColor];
    //设置分割线的样式,没有分割线
    //self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //设置tableHeaderView
    self.tableView.tableHeaderView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    //设置tableFooterView
    self.tableView.tableFooterView = [[UISwitch alloc]init];
    
    
}
//每行行高不一样情况，需要使用代理来实现对行高的设置
//代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int rowNum = (int)indexPath.row;
    if(rowNum % 2 == 0){
        return 60;
    }else{
        return 120;
    }
}


//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}




@end
