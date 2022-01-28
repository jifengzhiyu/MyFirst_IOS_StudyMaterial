//
//  EditUIViewController.m
//  day3
//
//  Created by 翟佳阳 on 2021/10/1.
//

#import "EditUIViewController.h"

@interface EditUIViewController ()
- (IBAction)editClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberFiled;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation EditUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置初始文本框的数据
    self.nameField.text = self.contact.name;
    self.numberFiled.text = self.contact.number;
    
    //监听保存按钮
    [self.saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    
}

//保存按钮的单击事件
-(void)saveClick{
    self.contact.name = self.nameField.text;
    self.contact.number = self.numberFiled.text;
    if([self.delegate respondsToSelector:@selector(editViewController:withContact:)]){
        Contact *con = [[Contact alloc] init];
   
        [self.delegate editViewController:self withContact:con];
    //它和viewDidLoad
    // self.nameField.text = self.contact.name;
    //self.numberFiled.text = self.contact.number;
    //都是同一个地址,此时需要contactView刷新
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editClick:(UIBarButtonItem *)sender {
    //if([sender.title isEqualToString:@"编辑"])
    if(self.saveBtn.hidden)
    {//点击编辑
    sender.title = @"取消";
    self.nameField.enabled = YES;
    self.numberFiled.enabled = YES;
    self.saveBtn.hidden = NO;
    //让电话的文本框成为第一响应者
        [self.numberFiled becomeFirstResponder];
    }else{
        sender.title = @"编辑";
        self.nameField.enabled = NO;
        self.numberFiled.enabled = NO;
        self.saveBtn.hidden = YES;
        
        //回复到传过来的模型数据
        self.nameField.text = self.contact.name;
        self.numberFiled.text = self.contact.number;
        
    }
}
@end
