//
//  JFRedViewController.m
//  通过storyboard使用导航控制器
//
//  Created by 翟佳阳 on 2021/9/29.
//

#import "JFRedViewController.h"
#import "JFGreenViewController.h"
@interface JFRedViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation JFRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma mark - 设置导航控制器的导航栏内容
    //1、设置文字标题
    self.navigationItem.title = @"红色控制器";
    //2、设置控件
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = addBtn;
    
    //3、设置UIBarButtonItem类型的按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(carmraClick)];
    //添加到左侧
    //self.navigationItem.leftBarButtonItem = left;
    //添加到右侧
    // self.navigationItem.rightBarButtonItem = left;
    
    //如果遇到多个控件的话
    UIBarButtonItem *left2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashClick)];
    //从右边开始添加
    //self.navigationItem.rightBarButtonItems = @[left,left2];
    
    //从左边开始添加
    self.navigationItem.leftBarButtonItems = @[left,left2];
    
    //显示在绿色控制器的返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"fanhui" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
}

-(void)trashClick{
    NSLog(@"垃圾桶");
}

-(void)carmraClick{
    NSLog(@"摄像机");
}

-(void)addBtnClick{
    NSLog(@"按钮被点击");
}




#pragma mark - Navigation


//通过stroyboard拖线的方式实现跳转的时候运行该方法
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //1、获取文本框内容
    NSString *text = self.textField.text;
    
    //2、获取目标控制器
    JFGreenViewController *greenVc = segue.destinationViewController;
    
    //3、设置标题
    greenVc.navigationItem.title = text;
    
}


@end
