//
//  ViewController.m
//  内存分析工具
//
//  Created by 翟佳阳 on 2022/1/1.
//

#import "ViewController.h"
#import "Dog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self touches];
}

- (void)touches
{
    Person *p = [Person new];
    Dog *d = [Dog new];
    
    p.dog = d;
    d.person = p;
}
@end
