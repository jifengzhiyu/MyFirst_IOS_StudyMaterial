//
//  ViewController.m
//  汽车右侧索引
//
//  Created by 翟佳阳 on 2021/9/13.
//

#import "ViewController.h"
#import "Group.h"
#import "Car.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray * groups;


@end

@implementation ViewController
#pragma mark - 监听行被选中的代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建一个对话框
    //获取名字
    Group * group = self.groups[indexPath.section];
    Car * car = group.cars[indexPath.row];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"你的车" message:@"你的车名字" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
          textField.placeholder = @"请输入车名";
          textField.keyboardType = UIKeyboardTypeDefault;
      }];
    UIAlertAction * conform = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *envirnmentNameTextField = alert.textFields.firstObject;
        car.name = envirnmentNameTextField.text;
        //重新刷新整个tableView
        //[tableView reloadData];
        
        //局部刷新
        //刷新指定的行


        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    }];
    
    [alert addAction:cancel];
    [alert addAction:conform];
    [self presentViewController:alert animated:YES completion:nil];
    
}


#pragma mark - 数据源方法
//返回一共多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

//返回每组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Group * group = self.groups[section];
    return group.cars.count;
}

//创建并设置单元格
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1、获取模型数据
    //1、1根据组的索引获取对应组的模型
    Group * group = self.groups[indexPath.section];
    //1、2根据当前行的索引，获取对应组对应行的车
    Car * car = group.cars[indexPath.row];
    
    //2、创建单元格
    //2、1声明一个重用ID
    static NSString * ID = @"car_cell";
    //2、2根据重用ID去缓存池中获取相应的cell对象
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //2、3如果没有获取到，就创建一个
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //3、设置单元格内容
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.textLabel.text = car.name;
    
    //4、返回单元格
    return cell;
}

//设置组头
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //获取组模型
    Group * group = self.groups[section];
    return group.title;
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
}

//设置UITableView右侧的索引栏
//索引栏会自动转到title对应内容
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.groups valueForKey:@"title"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}





#pragma mark - 懒加载数据
-(NSArray*)groups{
    if(_groups == nil){
        NSString * path = [[NSBundle mainBundle]pathForResource:@"cars_total.plist" ofType:nil];
        NSArray * arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * arrayModels = [NSMutableArray array];
        for (NSDictionary * dict in arrayDict) {
            Group * model = [Group groupWithDict:dict];
            [arrayModels addObject:model];
        }
        _groups = arrayModels;
    }
    return _groups;
}

@end
