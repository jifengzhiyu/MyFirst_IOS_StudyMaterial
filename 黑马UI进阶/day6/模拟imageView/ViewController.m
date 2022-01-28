//
//  ViewController.m
//  模拟imageView
//
//  Created by 翟佳阳 on 2021/10/5.
//

#import "ViewController.h"
#import "MyImageView.h"
@interface ViewController ()
@property (nonatomic, weak) MyImageView * imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self test1];
    [self test2];
    
}
    
- (void)test2{
    //initWithImage
    MyImageView *imageView = [[MyImageView alloc] initWithImage:[UIImage imageNamed:@"12"]];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
}


- (void) test1{
    //使用init
    MyImageView *imageView = [[MyImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.image = [UIImage imageNamed:@"23"];
    
    self.imageView = imageView;
    [self.view addSubview:imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.imageView.image = [UIImage imageNamed:@"22"];
    
}

@end
