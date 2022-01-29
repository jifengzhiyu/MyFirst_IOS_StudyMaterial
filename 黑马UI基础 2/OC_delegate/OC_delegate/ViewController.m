//
//  ViewController.m
//  OC_delegate
//
//  Created by Huawei on 2021/9/8.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel * dataReceiveFromSecondVCLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _iconImage.image = [UIImage imageNamed:@"2"];
    _iconImage.contentMode = UIViewContentModeTopRight;
}

- (void)changePaymentLabel {
    _dataReceiveFromSecondVCLabel.text = @"订单已经付款";
    _dataReceiveFromSecondVCLabel.backgroundColor = UIColor.cyanColor;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass: SecondViewController.class] == YES && segue.destinationViewController != nil) {
        
        SecondViewController * secVC = (SecondViewController *)segue.destinationViewController;
//        secVC.firstVC = self;
//        secVC.firstVC = segue.sourceViewController;
    }
}


@end
