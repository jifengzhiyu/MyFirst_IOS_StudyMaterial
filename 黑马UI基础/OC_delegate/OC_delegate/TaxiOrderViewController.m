//
//  TaxiOrderViewController.m
//  TaxiOrderViewController
//
//  Created by Huawei on 2021/9/8.
//

#import "TaxiOrderViewController.h"
#import "SecondViewController.h"

@interface TaxiOrderViewController ()<PaymentVCDelegate>

@property (weak, nonatomic) IBOutlet UILabel *paymentStateLabel;

@end

@implementation TaxiOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SecondViewController * secVC = (SecondViewController *)segue.destinationViewController;
    secVC.delegate = self;
    
}

- (void)orderChangeToPaidState {
    _paymentStateLabel.text = @"打车已经付款了";
    _paymentStateLabel.backgroundColor = UIColor.greenColor;
}



@end
