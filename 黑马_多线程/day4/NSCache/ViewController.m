//
//  ViewController.m
//  NSCache
//
//  Created by 翟佳阳 on 2021/10/28.
//

#import "ViewController.h"

@interface ViewController ()<NSCacheDelegate>
@property (nonatomic, strong) NSCache *cache;


@end

@implementation ViewController

- (NSCache *)cache{
    if(_cache == nil){
        _cache = [NSCache new];
        //设置缓存总共可以存储多少条
        _cache.countLimit = 5;
    }
    return _cache;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cache.delegate = self;

    //添加缓存数据
    for (int i = 0; i < 10; i++) {
        [self.cache setObject:[NSString stringWithFormat:@"hi%d",i] forKey:[NSString stringWithFormat:@"No%d",i]];
        NSLog(@"添加%d",i);
    }
    
    
    //输出
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"No%d",i]]);
    }
    
}

//将要从NSCache中移除一项的时候执行
- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    //NSLog(@"从缓存中移除 %@",obj);
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.cache removeAllObjects];
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"No%d",i]]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.cache removeAllObjects];
    for (int i = 0; i < 10; i++) {
        [self.cache setObject:[NSString stringWithFormat:@"hi%d",i] forKey:[NSString stringWithFormat:@"No%d",i]];
    }
    //输出
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[self.cache objectForKey:[NSString stringWithFormat:@"No%d",i]]);
    }
}
@end
