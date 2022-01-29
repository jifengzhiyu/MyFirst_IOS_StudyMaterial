//
//  ViewController.m
//  下载网络图片
//
//  Created by 翟佳阳 on 2021/10/25.
//

#import "ViewController.h"
#import "JFDownloadOperation.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSOperationQueue *queue;


@end

@implementation ViewController
- (NSOperationQueue *)queue{
    if(_queue == nil){
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    JFDownloadOperation *op = [JFDownloadOperation downloaderOperationWithURLString:@"http://p16.qhimg.com/dr/48_48_/t0125e8d438ae9d2fbb.png" finishedBlcok:^(UIImage * img){
        self.imageView.image = img;
    }];
    [self.queue addOperation:op];
}
@end
