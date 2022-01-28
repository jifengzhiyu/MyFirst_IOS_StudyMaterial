//
//  ViewController.m
//  核心动画-转场动画
//
//  Created by 翟佳阳 on 2021/10/8.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) NSInteger imageName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageName = 1;
}


//轻扫手势的方法
//连线两个不同方向的 轻扫手势
- (IBAction)imageChange:(UISwipeGestureRecognizer *)sender {
    
    self.imageName++;
    
    if(self.imageName == 5){
        self.imageName = 1;
    }
    
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",self.imageName]];
    
    //1、创建动画
    CATransition *anim = [[CATransition alloc] init];
    
    //2、操作
    anim.type = @"cube";
    
    if(sender.direction == UISwipeGestureRecognizerDirectionLeft){
        anim.subtype = kCATransitionFromRight;
    }else if(sender.direction == UISwipeGestureRecognizerDirectionRight){
        anim.subtype = kCATransitionFromLeft;
    }
    //3、添加动画
    [self.imageView.layer addAnimation:anim forKey:nil];

}


@end
