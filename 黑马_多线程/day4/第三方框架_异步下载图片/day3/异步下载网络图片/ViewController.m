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

@end
@implementation MyViewController


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
    return self.appInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"appInfo";
    JFAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];

    //设置数据
    MyAppInfo *appInfo = self.appInfos[indexPath.row];

    cell.appInfo = appInfo;
    
    return cell;
}


@end
