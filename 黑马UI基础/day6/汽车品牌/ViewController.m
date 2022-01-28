//
//  ViewController.m
//  汽车品牌
//
//  Created by 翟佳阳 on 2021/9/11.
//

#import "ViewController.h"
#import "JFcar.h"
@interface ViewController ()<UITableViewDataSource>
@property(nonatomic,strong)NSArray * cars;
@end

@implementation ViewController
//懒加载数据
-(NSArray *)cars{
    if(_cars == nil){
        //1、找到plist路径
        NSString * path = [[NSBundle mainBundle]pathForResource:@"cars.plist" ofType:nil];
        //2、加载plist文件
        NSArray * arrayDict = [NSArray arrayWithContentsOfFile:path];
        //3、将字典转化成模型
        NSMutableArray * arrayModel = [NSMutableArray array];
        //遍历，把字典转化成模型并存储
        for (NSDictionary * dict in arrayDict) {
            //创建模型对象
            JFcar * model = [JFcar carWithDict:dict];
            [arrayModel addObject:model];
        }
        _cars = arrayModel;
    }
    return _cars;
}
#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.cars.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据索引section获取组对象,展示的内容与组标题和组尾不一样，所以显示行数就只显示内容
    JFcar* car = self.cars[section];
    return car.cars.count;
}


//一下这些数据源方法都是内在有种循环的机制在搞，所以就使用index之类的，内部一个个执行下去
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1、获取模型数据
    JFcar * car = self.cars[indexPath.section];
    //获取对应的汽车品牌
    NSString * brand = car.cars[indexPath.row];
    //2、创建单元格UITableViewCell
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //3、把模型中的数据设置给单元格中的子控件
    cell.textLabel.text = brand;
    //4、返回单元格UITableViewCell
    return cell;
}

//设置组标题的数据源方法
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    JFcar * car = self.cars[section];
    return car.title;
}

//设置组描述的源方法
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    JFcar * car = self.cars[section];
    return  car.desc;
}

#pragma mark - 隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
