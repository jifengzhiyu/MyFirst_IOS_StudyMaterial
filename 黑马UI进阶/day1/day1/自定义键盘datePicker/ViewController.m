//
//  ViewController.m
//  自定义键盘datePicker
//
//  Created by 翟佳阳 on 2021/9/26.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong)UIDatePicker *datePicker;
@property(nonatomic, strong)UIToolbar *toolbar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置文本框的输入界面是datePicker
    self.textField.inputView = self.datePicker;
    
    //设置工具条
    self.textField.inputAccessoryView = self.toolbar;

    //获取项目文件
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    //NSLog(@"%@",dict);
    JFLog(@"%@",dict);
    //int a = [Tool sum:4 andB:9];
}
    
    


# pragma mark - 懒加载控件
- (UIDatePicker *)datePicker{
    
    if(!_datePicker){
        //不需要设置frame，自动会设置
        _datePicker = [[UIDatePicker alloc] init];
        //日期模式
        //_datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        //本地化local
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    }
    return _datePicker;
}

- (UIToolbar *)toolbar{
    if(!_toolbar){
        
        //只需要设定高度
        _toolbar = [[UIToolbar alloc] init];
        _toolbar.bounds = CGRectMake(0, 0, 0, 44);
        
        //创建按钮，放在工具条里面
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemClick)];
        
        //弹簧按钮
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        //确认
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(doneItemClick)];
        
        //注意顺序
        _toolbar.items = @[cancelItem,flexSpace,doneItem];

        
    }
    return _toolbar;
}
    
- (void)cancelItemClick{
    [self.view endEditing:YES];
    }

- (void)doneItemClick{
    //1、获取当前选中的日期
    NSDate *date = self.datePicker.date;
    //2、设置给文本框
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString *str = [formatter stringFromDate:date];
    self.textField.text = str;
     
    //3、关闭键盘
    [self.view endEditing:YES];
}
@end
