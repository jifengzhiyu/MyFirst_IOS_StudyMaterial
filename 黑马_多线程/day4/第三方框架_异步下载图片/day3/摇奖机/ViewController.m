//
//  ViewController.m
//  摇奖机
//
//  Created by 翟佳阳 on 2021/10/21.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;

@property (weak, nonatomic) IBOutlet UIButton *btn;

//全局队列
@property (nonatomic, strong) NSOperationQueue *queue;


@end

@implementation ViewController
- (NSOperationQueue *)queue{
    if(_queue == nil){
        _queue = [NSOperationQueue new];
    }
    return _queue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)start:(UIButton *)sender {
   
    //异步执行
    if(self.queue.operationCount == 0)
    {
        [self.queue addOperationWithBlock:^{
        [self random];
    }];
        [self.btn setTitle:@"暂停" forState:UIControlStateNormal];
        self.queue.suspended = NO;
    }else if(!self.queue.isSuspended){
        self.queue.suspended = YES;
        [self.btn setTitle:@"继续" forState:UIControlStateNormal];
    }
    
     
}

//点击生成随机数
- (void)random{
    
    //这样就不会在暂停之后还添加操作,
    //保证    if(self.queue.operationCount == 0) 有效
    while (!self.queue.isSuspended) {
        
        //减速
        [NSThread sleepForTimeInterval:0.05];
        //[0,10)   0-9
        int num1 = arc4random_uniform(10);
        int num2 = arc4random_uniform(10);
        int num3 = arc4random_uniform(10);

        //主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    self.lbl1.text = [NSString stringWithFormat:@"%d",num1];
                    self.lbl2.text = [NSString stringWithFormat:@"%d",num2];
                    self.lbl3.text = [NSString stringWithFormat:@"%d",num3];
        }];
    }
}
@end
