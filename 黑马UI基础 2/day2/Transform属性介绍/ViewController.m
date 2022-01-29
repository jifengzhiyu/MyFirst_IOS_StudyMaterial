//
//  ViewController.m
//  Transform属性介绍
//
//  Created by 翟佳阳 on 2021/8/31.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)move{
    //一次性平移，直接修改结构体的值
    //平移到距离原来位置-50的位置
//    self.btnIcon.transform = CGAffineTransformMakeTranslation(0, -50);
    
    
    
    //如果想要多次平移，需要基于每一次平移前旧的值进行平移
    self.btnIcon.transform = CGAffineTransformTranslate(self.btnIcon.transform, 0, 50);
    
   
}

-(IBAction)scale
{
    //一次性
//    self.btnIcon.transform = CGAffineTransformMakeScale(1.5, 1.5);
      
    
    //多次缩放
    self.btnIcon.transform = CGAffineTransformScale(self.btnIcon.transform, 1.5, 1.5);
}

-(IBAction)rotate{
    //一次性,顺时针旋转45度，如果逆时针写负数弧度
//    self.btnIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    
    //旋转多次，顺时针旋转45度，如果逆时针写负数弧度
   
    self.btnIcon.transform = CGAffineTransformRotate(self.btnIcon.transform, M_PI_4);
    
    
}
- (IBAction)next {
}
- (IBAction)next {
}

-(IBAction)animation{
    [UIView animateWithDuration:2.5 animations:^{
        
        self.btnIcon.transform = CGAffineTransformScale(self.btnIcon.transform, 1.5, 1.5);
        
        self.btnIcon.transform = CGAffineTransformTranslate(self.btnIcon.transform, 0, 50);
        
        self.btnIcon.transform = CGAffineTransformRotate(self.btnIcon.transform, M_PI_4);
    }
     ];
    
}


- (IBAction)goBack {
    self.btnIcon.transform = CGAffineTransformIdentity;
}



@end
