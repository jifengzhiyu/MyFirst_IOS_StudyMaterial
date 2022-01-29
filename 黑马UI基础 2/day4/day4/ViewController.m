//
//  ViewController.m
//  day4
//
//  Created by 翟佳阳 on 2021/9/4.
//

#import "ViewController.h"
#import "Questions.h"

@interface ViewController ()
@property(nonatomic,copy)NSArray * questions;

//控制题目索引,初始值0
@property(nonatomic,assign)int index;

@property (weak, nonatomic) IBOutlet UILabel *lblIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnScore;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;

//用来记录头像按钮原始的frame
@property(nonatomic,assign)CGRect iconFrame;

//用来引用阴影按钮，创建在{}里，是局部变量，在大括弧外面还需要使用要把它放在属性里面
@property(weak,nonatomic)UIButton *cover;

- (IBAction)btnNextClick;
- (IBAction)bigmage:(id)sender;
- (IBAction)btnIconClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;
@property (weak, nonatomic) IBOutlet UIButton *btnTipClick;
- (IBAction)btnTipClick;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    //初始化第一题
    self.index = -1;
    [self nextQuestion];
}
//改变状态栏的文字颜色为白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
//懒加载数据,重写getter
-(NSArray*)questions{
    if(_questions == nil){
        //加载数据
        NSString * path = [[NSBundle mainBundle]pathForResource:@"questions.plist" ofType:nil];
        NSArray * arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModel = [NSMutableArray array];
        
        //遍历把字典转模型
        for (NSDictionary *dict in arrayDict) {
            Questions * model = [Questions questionWithDict:dict];
            [arrayModel addObject:model];
        }
        _questions = arrayModel;
    }
    return _questions;
}


- (IBAction)btnNextClick {
//移动到下一题
    [self nextQuestion];
    

}
//再来一个回合
-(void)nextQuestionForAlert{
    self.index++;
    //2、根据索引获取当前的模型数据
    Questions * model = self.questions[self.index];
    //3、根据模型设置数据
    [self settingData:model];
    //4、动态创建答案按钮
    [self makeAnswerButtons:model];
    
    //5、动态创建待选按钮
    [self makeOptionsButton:model];
}
//下一题
-(void)nextQuestion{
    //1、让索引++
    self.index++;
    //判断当前索引是否越界，如果越界则提示用户
    if(self.index == self.questions.count){
        //弹出一个弹框
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"操作提示" message:@"恭喜过关" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.index = -1;
            [self nextQuestionForAlert];
        }];
        [alert addAction:conform];
        //显示对话框
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    //2、根据索引获取当前的模型数据
    Questions * model = self.questions[self.index];
    //3、根据模型设置数据
    [self settingData:model];
    //4、动态创建答案按钮
    [self makeAnswerButtons:model];
    
    //5、动态创建待选按钮
    [self makeOptionsButton:model];
}

//显示大图
- (IBAction)btnIconClick:(id)sender {
    if(self.cover == nil)
    {
        //显示大图
        [self bigmage:nil];
    }else
    {
        [self smallImage];
    }
}



//显示大图
- (IBAction)bigmage:(id)sender {
    //记录头像按钮的元素frame
    self.iconFrame = self.btnIcon.frame;
    
    //1、创建一个大小和self.view一样大的按钮，作为阴影
    UIButton * btnCover = [[UIButton alloc] init];
    //设置按钮大小
    btnCover.frame = self.view.frame;
    //设置按钮背景色
    btnCover.backgroundColor = [UIColor blackColor];
    //设置按钮透明度
    btnCover.alpha = 0.6;
    
    //把按钮添加到self.view中
    [self.view addSubview:btnCover];
    
    //为阴影按钮注册一个单击事件
    [btnCover addTarget:self action:@selector(smallImage) forControlEvents:UIControlEventTouchUpInside];
    
    //2、把图片设置到阴影的上面
    [self.view bringSubviewToFront:self.btnIcon];
    
    //通过self.cover来引用btnCover
    self.cover = btnCover;
    
    //3、通过动画的方式把图片放大
    CGFloat iconW = self.view.frame.size.width;
    CGFloat iconH = iconW;
    CGFloat iconX = 0;
    CGFloat iconY = (self.view.frame.size.height - iconH) / 2;
    
    [UIView animateWithDuration:2.0 animations:^{
        self.btnIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    }];
   
}

//还原图片
-(void)smallImage{
    [UIView animateWithDuration:0.7 animations:^{
        //1、设置头像的frame还原
        self.btnIcon.frame = self.iconFrame;
        //2、让阴影透明度恢复到1
        self.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(finished){
            //3、移除阴影按钮
            [self.cover removeFromSuperview];
            //头像恢复之后把self.cover的值改成nil
            self.cover = nil;
        }
    }];
    }

//加载数据，把模型数据设置到界面的空间上
- (void)settingData:(Questions *)model
{
    //3、把模型数据设置到界面对应的控件上
    self.lblIndex.text = [NSString stringWithFormat:@"%d/%lu",(self.index)+1,self.questions. count];
    self.lblTitle.text = model.title;
    [self.btnIcon setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    //4、设置到达最后一题以后，禁用“下一题”按钮
    self.btnNext.enabled = (self.index != self.questions.count -1);
}

//创建答案按钮
-(void)makeAnswerButtons:(Questions *)model
{
    //5.0清除所有的答案按钮
    //让subview这个数组里的所有对象分别调用一次removeFromSuperview方法，无需自己写循环
    [self.answerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //5.1获取当前答案的个数
    NSInteger len = model.answer.length;
    //设置按钮的frame
    CGFloat answerViewH = self.answerView.frame.size.height;
    CGFloat margin =10;//每个按钮的间距
    CGFloat answerW = answerViewH;
    CGFloat answerH = answerViewH;
    CGFloat answerY = 0;
    CGFloat marginLeft = (self.answerView.frame.size.width - (len * answerW) - (len - 1) * margin) / 2;
    //5.2循环创建答案按钮，根据答案的文字个数
    for(int i = 0; i < len; i++)
    {
        //创建按钮
        UIButton * btnAnswer = [[UIButton alloc] init];
        //设置背景颜色
        btnAnswer.backgroundColor = [UIColor whiteColor];
        //计算x值
        CGFloat answerX = marginLeft + i * (margin + answerW);
        btnAnswer.frame = CGRectMake(answerX, answerY, answerW, answerH);
        //设置答案按钮的文字颜色
        [btnAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //把按钮添加到answerView中
        [self.answerView addSubview:btnAnswer];
        //为答案按钮注册单击事件
        [btnAnswer addTarget:self action:@selector(btnAnswerClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

//把答案回收
-(void)btnAnswerClick:(UIButton *)sender
{
    //0、启用optionView的人机交互，可以继续填入新的答案
    self.optionsView.userInteractionEnabled = YES;
    
    //设置所有答案按钮的颜色为黑色
    [self setAnswerButtonsTitleColor:[UIColor blackColor]];
    //1、在待选按钮中找到与之前被点击答案按钮文字相同的待选按钮，将其显示出来
    //使用标签可以避免同样内容的答案按钮回归的顺序问题
    for(UIButton* optBtn in self.optionsView.subviews){
        if(sender.tag == optBtn.tag){
            optBtn.hidden = NO;
            break;
        }
        
    }
    //2、清空被点击答案按钮的文字
    [sender setTitle:nil forState:UIControlStateNormal];
}

//动态创建待选按钮
-(void)makeOptionsButton:(Questions *)model
{
    //0、设置optionsView可以人机交互
    self.optionsView.userInteractionEnabled = YES;
    
    //1、清除待选按钮的view中的所有子控件
    [self.optionsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //2、获取当前题目的待选文字的数组
    NSArray * words = model.options;
    //3、根据待选文字循环来创建按钮
    //指定每个待选按钮的大小
    CGFloat optionW = 35;
    CGFloat optionH = 35;
    CGFloat margin = 10;//间距
    int columns = 7;
    //每行的个数
    CGFloat marginLeft = (self.optionsView.frame.size.width - columns * optionW - margin * (columns - 1)) / 2;
    
    //计算每一行第一个按钮距离左边的距离
    for(int i = 0; i < words.count; i++){
        //创建一个按钮
        UIButton * btnOpt = [[UIButton alloc]init];
        
        //给每一个按钮一个唯一的tag
        btnOpt.tag = i;
        
        //设置按钮背景颜色
        btnOpt.backgroundColor = [UIColor whiteColor];
        //设置按钮文字
        [btnOpt setTitle:words[i] forState:UIControlStateNormal];
        //设置文字颜色黑色
        [btnOpt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
           
        //计算当前按钮的行索引和列索引
        int colIdx = i % columns;
        int rowIdx = i / columns;
        CGFloat optionsViewH = self.optionsView.frame.size.height;
        
        int hangShu = 0;
        if(words.count % columns != 0){
            hangShu = (int)words.count / columns + 1;
        }else{
            hangShu = (int)words.count / columns;
        }
        
        CGFloat marginUp = (optionsViewH - hangShu * optionH - margin * (hangShu - 1 )) / 2;
        //设置frame
        CGFloat optionX = marginLeft + (margin + optionW) * colIdx;
        CGFloat optionY = marginUp + (margin + optionH) * rowIdx;
        
        
        btnOpt.frame = CGRectMake(optionX, optionY, optionW, optionH);
        //把按钮添加到optionsView里面
        [self.optionsView addSubview:btnOpt];
        
        //为待选按钮注册单击事件
        [btnOpt addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

//为待选按钮注册单击事件
- (void)optionButtonClick:(UIButton *)sender
{
    //1、隐藏当前被点击的按钮
    sender.hidden = YES;
    //2、把当前被点击的按钮的文字显示到第一个为空的“答案按钮”
    //获取按钮指定状态下的文字
    //NSString * text = [sender titleForState:UIControlStateNormal];
    //获取按钮当前状态下的文字
    NSString * text = sender.currentTitle;
    //2.1把文字显示到答案按钮上
    //遍历答案按钮
    for(UIButton *answerBtn in self.answerView.subviews)
    {
        if(answerBtn.currentTitle == nil){
            //把当前待选按钮的文字设置给对应的答案按钮
            [answerBtn setTitle:text forState:UIControlStateNormal];
            //把当前点击的待选按钮的tag值也设置给对应的答案按钮
            answerBtn.tag = sender.tag;
            break;
        }
    }
    
    //3、判断答案按钮是否已经填满了
    //假设一开始是填满的
    BOOL isFull = YES;
    //声明一个用来保存用户输入答案的字符串
    NSMutableString * userInput = [NSMutableString string];
    for(UIButton *btnAnser in self.answerView.subviews){
        if(btnAnser.currentTitle == nil)
        {
            isFull = NO;
            break;
        }else{
            //如果当前答案按钮上有文字，就将这个文字拼接起来
            [userInput appendString:btnAnser.currentTitle];
        }
    }
    //如果答案按钮已经填满，禁止optionsView控件的人机交互
    if(isFull){
        self.optionsView.userInteractionEnabled = NO;
    //获取当前题目正确答案
        Questions * model = self.questions[self.index];
        
    //4、如果答案一致，文字设为蓝色，0.5秒后跳转下一题
        if([model.answer isEqualToString:userInput])
        {
            //如果正确加100分
            [self addScore:100];
            
            [self setAnswerButtonsTitleColor:[UIColor blueColor]];
            //延迟0.5秒，跳转下一题
            [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:0.5];
        }else{
            //如果答案不一致，按钮文字颜色设为红色
            [self setAnswerButtonsTitleColor:[UIColor redColor]];
        }
    }
 }

//根据指定的分数，对界面上的分数按钮进行加分和减分
-(void)addScore:(int)score
{
    //1、获取当前分值
    NSString * str = self.btnScore.currentTitle;
    //2、把当前分值转化成数字类型
    int currenScore = str.intValue;
    //3、对这个分数进行操作
    currenScore = currenScore + score;
    //4、把新的分数设置给按钮
    [self.btnScore setTitle:[NSString stringWithFormat:@"%d",currenScore] forState:UIControlStateNormal];
}

//统一设置答案按钮的文字颜色
-(void)  setAnswerButtonsTitleColor:(UIColor*)color
{
    //遍历每一个答案按钮，设置文字颜色
    for (UIButton * btnAnswer in self.answerView.subviews) {
        [btnAnswer setTitleColor:color forState:UIControlStateNormal];
    }
}
    
//点击提示按钮
- (IBAction)btnTipClick {
    //1、分数-200
    [self addScore:-200];
    
    //2、把所有的答案清空，即调用每个答案按钮的单击事件
    for (UIButton *btnAnswer in self.answerView.subviews) {
        [self btnAnswerClick:btnAnswer];
    }
    
    //3、根据索引，找到数据数组self.questions中对应的数据模型
    //获取并显示第一个答案文字，即调用对应option按钮单击事件
    Questions * model = self.questions[self.index];
    NSString * firstChar = [model.answer substringToIndex:1];
    for (UIButton * btnOpt in self.optionsView.subviews) {
        if([btnOpt.currentTitle isEqualToString:firstChar])
        {
            [self optionButtonClick:btnOpt];
            break;
        }
    }
    
}
@end
