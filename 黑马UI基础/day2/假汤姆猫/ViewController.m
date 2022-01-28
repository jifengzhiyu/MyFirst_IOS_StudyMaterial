//
//  ViewController.m
//  假汤姆猫
//
//  Created by 翟佳阳 on 2021/9/1.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewRun;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self sayHi];
    
}
-(IBAction)run{
    
    //如果动画还在执行时就不开始下一个动画
    if(self.imgViewRun.isAnimating){
        return;
    }
    //0、动态加载图片到一个NSArray中
    //创建一个NSMutableArray，长度不固定
    NSMutableArray * arrayM = [NSMutableArray array];
    //拼接图片名称
    for(int i = 1; i < 6; i++)
    {
        //把名字拿出来
        NSString * imgName = [NSString stringWithFormat:@"%d.jpeg",i];
        
        //根据图片名称加载图片
        //会产生缓存
//        UIImage * imgRun = [UIImage imageNamed:imgName];
        //不会产生缓存的方式：
        
        //获取图片路径
        NSString * path = [[NSBundle mainBundle]pathForResource:imgName ofType:nil];
        //传递图片路径
        UIImage * imgRun = [UIImage imageWithContentsOfFile:path];
        
        //将图片加载到数组里
        [arrayM addObject:imgRun];
    }
    
    //1、设置图片框UIImageView的animationImages属性，包含需要执行动画的图片
    self.imgViewRun.animationImages = arrayM;
    
    //2、设置动画持续时间
    self.imgViewRun.animationDuration = self.imgViewRun.animationImages.count * 1;
    
    //3、设置动画需要播放几次，如果不写默认无数次
    self.imgViewRun.animationRepeatCount = 1;
    
    //4、开启动画
    [self.imgViewRun startAnimating];
    
    //5、延迟一段时间后，让运行完了的图片清空
    [self.imgViewRun performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.imgViewRun.animationImages.count * 1];
    //等价于self.imgViewRun.animationImages = nil;
    //只要没有强指针指向该对象，该对象就会立即回收
}

///// sayHi方法
//-(void)sayHi{
//    NSLog(@"asss");
//}
@end
