//
//  ViewController.m
//  day8
//
//  Created by 翟佳阳 on 2021/9/16.
//

#import "ViewController.h"
#import "JFMessage.h"
#import "JFMessageFrame.h"
#import "JFMessageCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic, strong)NSMutableArray *messageFrames;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *txtinput;
@end

@implementation ViewController
# pragma mark - /************懒加载数据************/
- (NSMutableArray *)messageFrames{
    if(_messageFrames == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in arrayDict) {
            //创建一个数据模型
            JFMessage *model = [JFMessage messageWithDict:dict];
            //创建一个frame模型
            JFMessageFrame *modelFrame = [[JFMessageFrame alloc] init];
            
            //判断当前模型的发送时间 是否和上一个模型一致，一致，做标记
            //获取上一个数据模型
            JFMessage *lastMessage = (JFMessage *)[[arrayModels lastObject] message];
            //判断是否一致
            if([model.time isEqualToString:lastMessage.time]){
                // BOOL 默认值:0,即 NO 初始化
                model.ishideTime = YES;
            }
            
            //把frame模型添加到arrayModels
            modelFrame.message = model;
            [arrayModels addObject:modelFrame];
        }
        _messageFrames = arrayModels;
    }
    return _messageFrames;
}
# pragma mark - /************数据源方法************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1、获取模型数据
    JFMessageFrame *modelFrame = self.messageFrames[indexPath.row];
    //2、创建单元格
    JFMessageCell *cell = [JFMessageCell messageCellWithTableView:tableView];
    //3、把模型设置给单元格对象
    cell.messageFrame = modelFrame;
    //4、返回单元格
    return cell;
}

#pragma mark -/*************文本框的代理方法*********************/
//当键盘上的return键被单机时触发
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //1、获取用户输入的文本
    NSString *text = textField.text;
   //2、发送用户的消息
    [self sendMessage:text withType:JFMessageTypeMe];
    //3、发送一个系统消息
    [self sendMessage:@"????????????" withType:JFMessageTypeOther];
    //4、清空文本框
    textField.text = nil;
    
    return YES;

}

#pragma mark -/*************UITableView代理方法**************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JFMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    return messageFrame.rowHight;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //把键盘叫回 去
    //让控制器所管理的UIView结束编辑
    [self.view endEditing:YES];
}

# pragma mark - /************其他*****************/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置UITableView的背景
    self.tableView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    
    //设置UItableView的行不允许被选中
    self.tableView.allowsSelection = NO;
    
    //设置文本框最左侧有一段间距（使光标右移）
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, 5, 1);
    //把leftView设置给文本框
    self.txtinput.leftView = leftView;
    //什么时候显示leftView
    self.txtinput.leftViewMode = UITextFieldViewModeAlways;
    
    //监听键盘的弹出事件（不关心是哪个对象发布的通知
    //1、创建NSNotificationCenter对象
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //2、监听键盘的弹出通知（键盘通知：系统自动发布）
    //让控制器监听通知
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}

///控制器监听通知的方法
- (void)keyboardWillChangeFrame:(NSNotification *)noteInfo{
//    NSLog(@"通知名称: %@",noteInfo.name);
//    NSLog(@"通知发布者: %@",noteInfo.object);
//    NSLog(@"通知具体内容: %@",noteInfo.userInfo);
    
    //获取键盘的Y值
    //UIKeyboardFrameEndUserInfoKey是userInto的一个结构体
    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardY = rectEnd.origin.y;
    
    CGFloat transformValue = keyBoardY - self.view.frame.size.height;
    
    //平移
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformValue);
    }];
    
    //让UITableView的最后一行滚动到最上面
    NSIndexPath *lastIdxPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastIdxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

///移除通知
//**哪个对象监听通知，就让哪个对象的dealloc移除通知**
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)prefersStatusBarHidden{
    return YES ;
}

///发送消息
- (void)sendMessage:(NSString *)msg withType:(JFMessageType)type
{
    //2、创建一个数据模型和frame模型
    JFMessage *model = [[JFMessage alloc] init];
    //获取当前系统时间
    NSDate *nowDate = [NSDate date];
    //创建一个日期时间格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置格式
    formatter.dateFormat = @"今天 HH : mm";
    //日期时间的格式化
    model.time = [formatter stringFromDate:nowDate];
    
    model.type = type;
    model.text = msg;
    
    JFMessageFrame *modelFrame = [[JFMessageFrame alloc] init];
    modelFrame.message = model;
    
    //根据当前消息的时间和上一条消息的时间，设置是否需要隐藏时间lable
    JFMessageFrame *lastMessageFrame = [self.messageFrames lastObject];
    NSString *lastTime = lastMessageFrame.message.time;
    if([model.time isEqualToString:lastTime]){
        model.ishideTime = YES;
    }
    
    //3、把frame模型加到集合中
    [self.messageFrames addObject:modelFrame];
    
    //4、刷新UITableView的数据
    [self.tableView reloadData];
    
    //5、把最后一行滚动到最上面
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
@end
