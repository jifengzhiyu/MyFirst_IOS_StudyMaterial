//
//  ViewController.m
//  表盘练习
//
//  Created by 翟佳阳 on 2021/10/8.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) CALayer *second;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建表盘
    CALayer *clock = [[CALayer alloc] init];
    clock.bounds = CGRectMake(0, 0, 200, 200);
    clock.position = CGPointMake(200, 200);
    clock.contents = (__bridge id)[UIImage imageNamed:@"clock"].CGImage;
    //设置圆角
    clock.cornerRadius = 50;
    clock.masksToBounds = YES;
    
    //创建秒针
    CALayer *second = [[CALayer alloc] init];
    second.bounds = CGRectMake(0, 0, 2, 100);
    second.position = clock.position;
    second.backgroundColor = [UIColor redColor].CGColor;
    
    //锚点/定位点
    second.anchorPoint = CGPointMake(0.5, 0.8);
    
    //注意添加的先后顺序 决定谁覆盖谁
    [self.view.layer addSublayer:clock];
    [self.view.layer addSublayer:second];
    
    self.second = second;
    //计时器
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    //计时器不够准确
    //换 显示连接 和屏幕刷新频率保持一致
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
    //添加到死循环(主循环）里
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    
    [self timeChange];
    
}

- (void)timeChange{
    //NSLog(@"timeChange");
    
    //一秒 旋转的角度
    CGFloat angle = 2 * M_PI /60;
    
    NSDate *date = [NSDate date];

    //法1:NSDate
//    //创建一个时间格式化对象
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"ss";
//    CGFloat time = [[formatter stringFromDate:date] floatValue];
//    //不累加
//    self.second.affineTransform = CGAffineTransformMakeRotation(time * angle);
    
    //法2：日历
    NSCalendar *cal = [NSCalendar currentCalendar];
    CGFloat time = [cal component:NSCalendarUnitSecond fromDate:date];
    self.second.affineTransform = CGAffineTransformMakeRotation(time * angle);
}

@end
