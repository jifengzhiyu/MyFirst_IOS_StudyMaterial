//
//  ViewController.m
//  day4
//
//  Created by 翟佳阳 on 2021/10/25.
//

#import "ViewController.h"
#import "JFDownloadOperation.h"
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
    
    //自定义operation
    //把操作内容封装到main里面
    //子线程执行
//    JFDownloadOperation *op = [[JFDownloadOperation alloc] init];
//    op.urlString = @"xxxxxx.jpg";
//    //在operation里面自动调用
//    //但是无法传递参数
//    //自己设置block，传递图片
////    [op setCompletionBlock:^{
////        NSLog(@"给控件赋值");
////    }];
//    [op setFinishedBlock:^(UIImage * img) {
//                    NSLog(@"给控件赋值");
//    }];
//    [self.queue addOperation:op];

    for(int i = 0; i < 20; i++){
    JFDownloadOperation *op = [JFDownloadOperation downloaderOperationWithURLString:@"asa.jpg" finishedBlcok:^(UIImage *  img) {
        
        NSLog(@"更新UI--%@--%@---%d",op.urlString,[NSThread currentThread],i);
    }];
        [self.queue addOperation:op];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //把所有操作的canceled属性 设置为 yes
    [self.queue cancelAllOperations];
    NSLog(@"取消");
}

@end
