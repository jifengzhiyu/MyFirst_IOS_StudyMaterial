//
//  AddViewController.m
//  day3
//
//  Created by 翟佳阳 on 2021/10/1.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //实时监听两个文本框内容的变化
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.numberField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    //监听 添加按钮 的点击事件
    [self.addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    //让姓名文本框成为第一响应者 可以在出现addView界面的时候就弹出键盘，直接写到姓名里面
    [self.nameField becomeFirstResponder];
}

//添加按钮 的点击事件
- (void)addClick{
    //判断代理方法能否响应
    if([self.delegate respondsToSelector:@selector(addViewController:withContact:)]){
        //可以响应的话，执行代理方法
        
        Contact *con = [[Contact alloc]init];
        con.name = self.nameField.text;
        con.number = self.numberField.text;
        [self.delegate addViewController:self withContact:con];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textChange{
    self.addBtn.enabled = self.nameField.text.length > 0 && self.numberField.text.length > 0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
