//
//  ViewController.m
//  strong&weak
//
//  Created by 翟佳阳 on 2021/10/19.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
@property (nonatomic, weak) Person *p1;
@property (nonatomic, weak) Person *p2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.p1 = [[Person alloc] init];
    self.p1.name = @"aaaaa";
    NSLog(@"p1:%@",self.p1.name);
    
    self.p2 = [Person personWithName:@"bbbbbbbbbb"];
    NSLog(@"p1:%@",self.p2.name);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"p1:%@",self.p1.name);
    NSLog(@"p1:%@",self.p2.name);
    
}
@end
