//
//  ViewController.m
//  json文件解析
//
//  Created by 翟佳阳 on 2021/10/15.
//

#import "ViewController.h"
#import "Product.h"
@interface ViewController ()
@property (nonatomic, strong) NSArray *products;


@end

@implementation ViewController

//懒加载
- (NSArray *)products{
    if(!_products){
        
        //1、获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"more_project.json" ofType:nil];
        
        //2、1转化NSData
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        //2、2转化数组
        NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //3、初始化可变数组
        NSMutableArray *array = [NSMutableArray array];
        
        //4、遍历 获取字典
        for (NSDictionary *dict in tempArray) {
            //5、字典转模型
            Product *p = [Product productWithDict:dict];
            
            //6、把模型添加到可变数组里
            [array addObject:p];
        }
        
        //7、赋值
        _products = array;
    }
    return _products;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.products);
}


@end
