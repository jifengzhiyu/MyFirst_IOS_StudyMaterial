//
//  ViewController.m
//  day3
//
//  Created by 翟佳阳 on 2021/10/21.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *queue;


@end

@implementation ViewController

- (NSOperationQueue *)queue{
    if(_queue == nil){
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 2;
    }
    return _queue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < 100; i++) {
        [self.queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"%d--%@",i,[NSThread currentThread]);
        }];
    }
}

//取消所有操作  当前正在执行的操作会执行完毕，取消后续的所有操作
- (IBAction)cancel:(id)sender {
    [self.queue cancelAllOperations];
    NSLog(@"canceled");
}

//暂停 操作   当前正在执行的操作，会执行完毕，后续的操作会暂停
- (IBAction)suspend:(id)sender {
    self.queue.suspended = YES;
    NSLog(@"suspended");
}

- (IBAction)resume:(id)sender {
    self.queue.suspended = NO;
    NSLog(@"resumed");
}

//当操作执行完毕，会从队列中移除
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%zd",self.queue.operationCount);
}

@end
