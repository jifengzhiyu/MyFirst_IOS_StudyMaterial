//
//  ViewController.m
//  day5.2
//
//  Created by 翟佳阳 on 2021/9/10.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.maximumZoomScale = 3.5;
    self.scrollView.minimumZoomScale = 0.2;
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imgView;
}


@end
