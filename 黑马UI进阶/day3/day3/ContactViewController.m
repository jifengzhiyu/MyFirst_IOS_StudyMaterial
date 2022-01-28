//
//  ContactViewController.m
//  day3
//
//  Created by 翟佳阳 on 2021/9/30.
//

#import "ContactViewController.h"
#import "AddViewController.h"
#import "EditUIViewController.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"contacts.data"]
@interface ContactViewController ()<AddViewControllerDelegate,EditViewControllerDelegata>


@end

@implementation ContactViewController

///懒加载
- (NSMutableArray *)contacts{
    if(!_contacts){
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.leftBarButtonItem = item;

    self.navigationItem.title = [NSString stringWithFormat:@"%@的联系人", self.username];
    
    //取消tableView里面的分割线
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    //解档联系人信息
    NSData *data = [NSData dataWithContentsOfFile:kFilePath];
    self.contacts = (NSMutableArray *)[NSKeyedUnarchiver unarchivedArrayOfObjectsOfClass:[Contact class] fromData:data error:nil];
    
    
    
}

- (void)logOut{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"确定要注销吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionDefault = [UIAlertAction actionWithTitle:@"取消1" style:UIAlertActionStyleDefault handler:nil];
    
    
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];  
    }];
    UIAlertAction *actionCancle = [UIAlertAction actionWithTitle:@"取消2" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"%d",12);
    }];
    
    [alertVc addAction:actionDefault];

    [alertVc addAction:destructive];
    [alertVc addAction:actionCancle];
    
    
    [self presentViewController:alertVc animated:YES completion:nil];

}
//只要使用故事版，都会调用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //接下来的两个控制器都是直接或间接 UIViewController
    UIViewController *vc = segue.destinationViewController;
    //判断目标控制器的真实类型
    if([vc isKindOfClass:[AddViewController class]]){
        //设置代理
        //Xcode只知道是UIViewController类型，所以需要强转类型
        AddViewController *add = (AddViewController *)vc;
        add.delegate = self;
    }else{
        //顺传赋值
        EditUIViewController *edit = (EditUIViewController *)vc;
        
        edit.delegate = self;
        
        //获取点击cell的位置
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        //获取模型
        Contact *con = self.contacts[path.row];
        //赋值
        edit.contact = con;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

//用来添加联系人（逆传 的代理方法
-(void)addViewController:(AddViewController *)addViewController withContact:(Contact *)contact{
    //把模型数据放在contacts数组里
    [self.contacts addObject:contact];
    [self.tableView reloadData];
    
    //归档联系人信息
    //归档数组
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.contacts requiringSecureCoding:NO error:nil];
    [data writeToFile:kFilePath atomically:YES];
    //NSLog(@"%@",self.contacts);

    }

    //编辑联系人的代理方法
    - (void)editViewController:(EditUIViewController *)editViewController withContact:(Contact *)contact{
        [self.tableView reloadData];
        //归档编辑后的
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.contacts requiringSecureCoding:NO error:nil];
        [data writeToFile:kFilePath atomically:YES];
    }
    
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"contact_cell";
    //去缓存池找
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    Contact *contact = self.contacts[indexPath.row];
    //赋值
    cell.textLabel.text = [contact name];
    cell.detailTextLabel.text = [contact number];
    return cell;
    
}
# pragma mark - 让tableView进入编辑模式
    - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
        //把数组里的元素删除
        //[self.contacts removeObject:self.contacts[indexPath.row]];
        [self.contacts removeObjectAtIndex:indexPath.row];
        //刷新
        //[self.tableView reloadData];
        
        //删除一行
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        //该方法自动调用数据源方法（刷新 ，并且可以指定动画
        //传进去数组的原因：可以删除多个cell
    }

@end
