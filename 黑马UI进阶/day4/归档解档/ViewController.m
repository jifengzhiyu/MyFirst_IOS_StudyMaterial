//
//  ViewController.m
//  归档解档
//
//  Created by 翟佳阳 on 2021/10/2.
//

#import "ViewController.h"
#import "Teacher.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)save_Gui:(id)sender {
    //获取tmp目录
    NSString *tmpPath = NSTemporaryDirectory();
    //获取file path
    NSString *filePath = [tmpPath stringByAppendingPathComponent:@"teacher.arc"];
    //后缀名不和常见类型撞上就行
    
    //创建自定义对象
    Teacher *t = [[Teacher alloc] init];
    t.name = @"啊啊啊";
    t.age = 29;
    
    //归档
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:t requiringSecureCoding:NO error:nil];
    [data writeToFile:filePath atomically:YES];

}


- (IBAction)read_Gui:(id)sender {
    
    //获取tmp目录
    NSString *tmpPath = NSTemporaryDirectory();
    //获取file path
    NSString *filePath = [tmpPath stringByAppendingPathComponent:@"teacher.arc"];
    //后缀名不和常见类型撞上就行
    
    //解档
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    Teacher *t = [NSKeyedUnarchiver unarchivedObjectOfClass:[Teacher class] fromData:data error:nil];
    NSLog(@"%d",t.age);
}



@end
