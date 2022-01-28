//
//  ViewController.m
//  小画板
//
//  Created by 翟佳阳 on 2021/10/8.
//

#import "ViewController.h"
#import "JFView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UISlider *lineWidthProgress;
@property (weak, nonatomic) IBOutlet JFView *JFView;




@end

@implementation ViewController


- (IBAction)eraser:(id)sender {
    [self.JFView eraser];
}

- (IBAction)back:(id)sender {
    [self.JFView back];

}

- (IBAction)clear:(id)sender {
    [self.JFView clear];

}

//保存相册
- (IBAction)save:(id)sender {
    //开启图片类型的上下文
    UIGraphicsBeginImageContextWithOptions(self.JFView.bounds.size, NO, 0);
    
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //截图
    [self.JFView.layer renderInContext:ctx];
    
    //取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //默认第一次有线宽
    self.JFView.lineWidth = self.lineWidthProgress.value;
    
    //默认点击第一个颜色按钮
    [self lineColorChane:self.firstBtn];
}


- (IBAction)lineWidthChange:(UISlider *)sender {

    //设置最新的线宽
    self.JFView.lineWidth = sender.value;
}

- (IBAction)lineColorChane:(UIButton *)sender {
    
    //设置颜色
    self.JFView.lineColor = sender.backgroundColor;
}

@end
