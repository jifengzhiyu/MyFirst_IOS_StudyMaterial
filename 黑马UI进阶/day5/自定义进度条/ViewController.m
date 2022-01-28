//
//  ViewController.m
//  自定义进度条
//
//  Created by 翟佳阳 on 2021/10/4.
//

#import "ViewController.h"
#import "TestView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet TestView *progressView;

@end

@implementation ViewController

- (IBAction)ProgressChange:(UISlider *)sender {
    //把当前的value传给testView
    self.progressView.progressValue = sender.value;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
