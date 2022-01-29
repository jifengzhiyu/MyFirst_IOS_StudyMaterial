//
//  ViewController.m
//  异步下载网络图片
//
//  Created by 翟佳阳 on 2021/10/21.
//

#import "ViewController.h"
#import "MyAppInfo.h"
#import "JFAppInfoCell.h"
#import "NSString+sandBox.h"
@interface MyViewController ()
@property (nonatomic, copy) NSArray *appInfos;
@property (nonatomic, strong) NSOperationQueue *queue;
//图片的缓存池
@property (nonatomic, strong) NSMutableDictionary *imageCache;
//下载操作缓存池
@property (nonatomic, strong) NSMutableDictionary *downloadCache;


@end
@implementation MyViewController

- (NSMutableDictionary *)imageCache {
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _imageCache;
}

- (NSMutableDictionary *)downloadCache{
    if(_downloadCache == nil){
        _downloadCache = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _downloadCache;
}

- (NSOperationQueue *)queue{
    if(_queue == nil){
        _queue = [NSOperationQueue new];
    }
    return _queue;
}
- (NSArray *)appInfos{
    if(_appInfos == nil){
        _appInfos = [MyAppInfo appInfos];
    }
    return _appInfos;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //NSLog(@"%@",self.appInfos);

}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.appInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"appInfo";
    JFAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
//    }
    //设置数据
    MyAppInfo *appInfo = self.appInfos[indexPath.row];
//    cell.detailTextLabel.text = appInfo.download;
//    cell.textLabel.text = appInfo.name;
    cell.appInfo = appInfo;
    
    //判断有没有缓存图片，有的话直接用
    //这一个值存在（图片存在）
    if(self.imageCache[appInfo.icon]){
        NSLog(@"缓存图片");
        cell.iconView.image = self.imageCache[appInfo.icon];
        return cell;
    }
    
    //设置占位图片
    cell.iconView.image = [UIImage imageNamed:@"user_default"];
    
    //检查沙盒内是否有图片
    //有的话存储到内存中
    NSData *data = [NSData dataWithContentsOfFile:[appInfo.icon appendCache]];
    if(data){
        UIImage *img = [UIImage imageWithData:data];
        self.imageCache[appInfo.icon] = img;
        cell.iconView.image = img;
        NSLog(@"从沙盒加载图片");
        return cell;
    }
    
    //下载图片
    [self downloadImage:indexPath];
    
    return cell;
}

//收到内存警告
- (void)didReceiveMemoryWarning{
    //清理内存
    [self.imageCache removeAllObjects];
    [self.downloadCache removeAllObjects];
    
}

//异步下载图片
- (void)downloadImage:(NSIndexPath *)indexPath{
    MyAppInfo *appInfo = self.appInfos[indexPath.row];
    
    //判断下载操作缓存池 中是否有对应的操作
    //不添加重复操作
    //判断在占位图片下面（避免重用问题
    if (self.downloadCache[appInfo.icon]) {
        NSLog(@"正在拼命下载图片...");
        return;
    }
    
    //异步下载图片
    //模拟网速
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"下载网络图片");
        NSURL *url = [NSURL URLWithString:appInfo.icon];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
       // NSLog(@"%@",image);
        //保存图片到沙盒，之前先判断图片是否存在
        if(image){
            [data writeToFile:[appInfo.icon appendCache]atomically:YES];
        }
        
        
        //主线程更新UI
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            
            //操作mutable线程不安全
            //放在主队列就安全了

            //无网络状态下图片为空，会无限下载，返回cell
            if(image){
            //缓存图片
            //[appInfo.icon]的string设置 键名
            //image地址设置 值
            self.imageCache[appInfo.icon] = image;
            
            //移除下载 操作缓存池 里面的当前操作（解决循环引用问题
            [self.downloadCache removeObjectForKey:appInfo.icon];
            
            
            //在重用单元格的基础上 更新图片
//                    cell.imageView.image = image;
            //这个方法会造成单元格重用问题
            //表现：往下拉，再往上拉，上面的cell图片显示错误
            //因为网络更新图片有延迟，显示还是之前重用单元格的图片，会出现重用问题
            //解决：刷新
            //再调用数据源方法的时候就有了 缓存图片
            //更新以前对应的cell
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
    }];
    [self.queue addOperation:op];
    
    //把操作添加到下载操作缓存池中
    self.downloadCache[appInfo.icon] = op;
}
@end
