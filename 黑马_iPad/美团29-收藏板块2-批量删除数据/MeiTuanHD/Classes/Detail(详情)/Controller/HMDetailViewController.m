//
//  HMDetailViewController.m
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMDetailViewController.h"
#import "HMDealModel.h"
#import "HMCenterLineLabel.h"
#import "HMDealTool.h"

@interface HMDetailViewController ()<UIWebViewDelegate, DPRequestDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet HMCenterLineLabel *listPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *purchaseCountButton;
@property (weak, nonatomic) IBOutlet UIButton *refundableButton;
@property (weak, nonatomic) IBOutlet UIButton *expireRefundableButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@end

@implementation HMDetailViewController

#pragma mark 设置屏幕支持的旋转方法
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     -前面的东西, 其实是城市的标识符
     2-14316789
     241-11916122
     http://m.dianping.com/tuan/deal/14316789
     http://m.dianping.com/tuan/deal/moreinfo/14316789
     
     http://m.dianping.com/tuan/deal/14304806
     http://m.dianping.com/tuan/deal/moreinfo/14304806
     */
    
    // 截取 ID
    //1. 获取-的索引位置
    NSInteger location = [self.dealModel.deal_id rangeOfString:@"-"].location;
    
    //2. 截取字符串
    NSString *dealID = [self.dealModel.deal_id substringFromIndex:location + 1];
    
    //3. 加载网页数据
    NSString *urlStr = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", dealID];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    self.webView.delegate = self;
    
    //设置网页内容偏移
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    // 设置颜色
    self.webView.backgroundColor = HMColor(240, 240, 240);
    self.view.backgroundColor = HMColor(240, 240, 240);
    
    
    // 给界面赋值
    [self setupUI];
    
    // 发送请求 --> 获取详情信息
    [self addRequest];
    
    // 一进去界面, 就应该去数据库查询, 是否添加了此模型
    self.collectButton.selected = [HMDealTool isCollectDeal:self.dealModel];
}

#pragma mark - 收藏按钮点击方法
- (IBAction)collectButtonClick:(UIButton *)sender {
    
    //1. 如果按钮当前是选中状态, 应该删除
    if (sender.selected) {
        [HMDealTool removeCollectDeal:self.dealModel];
    } else {
        [HMDealTool insertCollectDeal:self.dealModel];
    }

    //2. 按钮状态取反
    sender.selected = !sender.selected;
    
    //3. 调用 block --> 不需要传值. 当收藏板块 block 回调一旦相应, 只需要重新加载数据即可
    if (self.detailVCCollectClick) {
        self.detailVCCollectClick();
    }
}


#pragma mark  - 网络请求
- (void)addRequest
{
    //1. 创建 DPASI 对象
    DPAPI *api = [DPAPI new];
    
    //2. 设置参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"deal_id"] = self.dealModel.deal_id;
    
    //3. 发送请求
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
}

#pragma mark 请求成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // self.dealModel --> 首页传过来的数据, 限制数据没有
    // 获取之后, 对此模型重新赋值即可

    //1. 重新获取模型数据
    self.dealModel = [HMDealModel yy_modelWithJSON:[result[@"deals"] firstObject]];
    
    //2. 设置 随时退款按钮 过期退款
    self.refundableButton.selected = self.dealModel.restrictions.is_refundable;
    
    self.expireRefundableButton.selected = self.dealModel.restrictions.is_refundable;
    
//    NSLog(@"result: %@", );
    
    
}

#pragma mark 请求失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
}

#pragma mark -给界面赋值
- (void)setupUI
{
    //1. 图像
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.dealModel.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    
    //2. 标题
    self.titleLabel.text = self.dealModel.title;
    
    //3. 详情
    self.descLabel.text = self.dealModel.desc;
    
    //4. 当前价格
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %@", self.dealModel.current_price];

    //4.1 查找小数点位置
    NSInteger currentPriceLocation = [self.currentPriceLabel.text rangeOfString:@"."].location;
    
    //4.2 判断有没有找到小数点位置
    if (currentPriceLocation != NSNotFound) {
        
        //4.3 如果找到了小数点位置 总长度 - 小数点的位置 > 3 需要截取
        if (self.currentPriceLabel.text.length - currentPriceLocation > 3) {
            
            //4.4 重新赋值: 将字符串转换层 float 类型, 再赋值
            self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f", [self.dealModel.current_price floatValue]];
        }
    }
    
    
    //5. 原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥ %@", self.dealModel.list_price];
    
    //5.1 查找小数点位置
    NSInteger listPriceLocation = [self.listPriceLabel.text rangeOfString:@"."].location;
    
    //5.2 判断有没有找到小数点位置
    if (listPriceLocation != NSNotFound) {
        
        //5.3 如果找到了小数点位置
        if (self.listPriceLabel.text.length - listPriceLocation > 3) {
            
            //5.4 重新赋值: 将字符串转换层 float 类型, 再赋值
            self.listPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f", [self.dealModel.list_price floatValue]];
        }
    }
    
    //6. 已售
    [self.purchaseCountButton setTitle:[NSString stringWithFormat:@"已售: %zd", self.dealModel.purchase_count] forState:UIControlStateNormal];
    
    //7. 倒计时的问题
    /**
     1. 获取过期的时间 
     2. 获取今天的时间
     3. 比较时间 --> 天/小时/分钟 --> 将数据全部转换成 NSDate --> 有专门比较时间的方法 , 可以直接获取2个日期的差值
     */
    //2016-03-30
    
    //当前日期: 2016-03-07 15:09:00
    //模型日期: 2016-03-08 00:00:00 -->  2016-03-07 23:59:59
    
    //1. 获取当前日期
    NSDate *nowDate = [NSDate date];
    
    //2. 创建日期格式化的类
    NSDateFormatter *fmt = [NSDateFormatter new];
    
    //3. 设置转换的格式
    fmt.dateFormat = @"yyyy-MM-dd";
    
    //4. 转换日期格式 --> 模型--> 字符串 --> NSDate
    NSDate *deadDate = [fmt dateFromString:self.dealModel.purchase_deadline];
    
    //5. 给过期时间增加一天
    deadDate = [deadDate dateByAddingTimeInterval:24 * 60 * 60];
    
    //6. 设置要比较的组件
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    //7. 比较
    //components: 要比较的组件 天/小时/周
    //fromDate: 开始时间
    //toDate: 截止时间
    NSDateComponents *cmps = [[NSCalendar currentCalendar] components:unit fromDate:nowDate toDate:deadDate options:0];
    
    if (cmps.day > 365) {
        [self.timeButton setTitle:@"一年内不过期" forState:UIControlStateNormal];
    } else {
        [self.timeButton setTitle:[NSString stringWithFormat:@"%ld天%ld小时%ld分钟", cmps.day, cmps.hour, cmps.minute] forState:UIControlStateNormal];
    }

    //NSLog(@"date: %@  deadDate: %@",nowDate, deadDate);
}

#pragma mark 当网页加载完成的方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //控制进度指示器的隐藏
    [self.indicator stopAnimating];
    
    // 删除网页内不需要的内容
    NSMutableString *js = [NSMutableString string];
    
    //1. 顶部的返回 --> 起名字 结尾要加;
    [js appendFormat:@"var header = document.getElementsByTagName('header')[0];"];
    //删除时需要找到父标签 --> 自己干掉自己, 下不去手
    //parentNode:父标签
    //removeChild:移除子标签内容
    [js appendFormat:@"header.parentNode.removeChild(header);"];
    
    //2. 顶部的立即购买
    [js appendFormat:@"var box = document.getElementsByClassName('cost-box')[0];"];
    [js appendFormat:@"box.parentNode.removeChild(box);"];
    
    //3. 底部的footer
    [js appendFormat:@"var footer = document.getElementsByClassName('footer')[0];"];
    [js appendFormat:@"footer.parentNode.removeChild(footer);"];
    
    //4. 底部的立即购买
    [js appendFormat:@"var buy  = document.getElementsByClassName('buy-now ')[0];"];
    [js appendFormat:@"buy.parentNode.removeChild(buy);"];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
}

#pragma mark 当加载一个请求的时候调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //NSLog(@"request: %@", request.URL.absoluteString);
    
    /**
     JS 代码, 不用记. 用过的可以保存, 问前端
     JS 代码, 在 Xcode, 没有智能提示, 容易写错.
     */
    //1. 通过 JS 代码来获取网页内容
    //document: ViewController
    //getElementsByTagName: 根据标签名获取内容 , 返回一个数组
    //[0]: 获取数组的第一个元素
    //outerHTML: 获取 html 标签的所有内容    <html><....></html>
    //interHTMl: 除去 html 标签以外的所以内容 <....>
    //NSString *js = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].outerHTML;"];
    
    
//    // 删除网页内不需要的内容
//    NSMutableString *js = [NSMutableString string];
//    
//    //1. 顶部的返回 --> 起名字 结尾要加;
//    [js appendFormat:@"var header = document.getElementsByTagName('header')[0];"];
//    //删除时需要找到父标签 --> 自己干掉自己, 下不去手
//    //parentNode:父标签
//    //removeChild:移除子标签内容
//    [js appendFormat:@"header.parentNode.removeChild(header);"];
//    
//    //2. 顶部的立即购买
//    [js appendFormat:@"var box = document.getElementsByClassName('cost-box')[0];"];
//    [js appendFormat:@"box.parentNode.removeChild(box);"];
//    
//    //3. 底部的footer
//    [js appendFormat:@"var footer = document.getElementsByClassName('footer')[0];"];
//    [js appendFormat:@"footer.parentNode.removeChild(footer);"];
//    
//    //4. 底部的立即购买
//    [js appendFormat:@"var buy  = document.getElementsByClassName('buy-now ')[0];"];
//    [js appendFormat:@"buy.parentNode.removeChild(buy);"];
//    
//    [webView stringByEvaluatingJavaScriptFromString:js];
    
    return YES;
}

- (IBAction)backClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
