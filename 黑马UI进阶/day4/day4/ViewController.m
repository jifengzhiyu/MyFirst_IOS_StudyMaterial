//
//  ViewController.m
//  day4
//
//  Created by 翟佳阳 on 2021/10/2.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)save_day4:(id)sender {
    //获取doc路径
    //1、1拼接字符串
//    NSString *homePath = NSHomeDirectory();
//    NSString *docPath = [homePath stringByAppendingString:@"/Documents"];
//    NSLog(@"%@",docPath);
    
    //1、2拼接字符串
//    NSString *homePath = NSHomeDirectory();
//    NSString *docPath = [homePath stringByAppendingPathComponent:@"Documents"];
//    NSLog(@"%@",docPath);
    
    //2、搜索（用这个
    //返回NSArray<NSString *> *
    //找到同名文件里面我们想要的那个，因为doc不可能有同名文件所以[0]
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    
    //存数据
    NSString *filePath = [docPath stringByAppendingPathComponent:@"xx.plist"];
    //数组
//    NSArray *array = @[@"1",@"asdasd",@"速度速度"];
//    [array writeToFile:filePath atomically:YES];
    //如果之前该文件已经存储数据，那么之前的数据就会被替换
    
    NSDictionary *dict = @{@"key" : @"value"};
    [dict writeToFile:filePath atomically:YES];
}

- (IBAction)read_day4:(id)sender {
    //获取doc路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //获取文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"xx.plist"];
    //解析
    //数组
    //NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
//    NSLog(@"%@",array);

    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"%@",dict);
}




@end
