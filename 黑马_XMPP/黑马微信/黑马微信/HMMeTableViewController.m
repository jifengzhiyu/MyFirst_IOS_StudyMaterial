//
//  HMMeTableViewController.m
//  黑马微信
//
//  Created by apple on 16/2/28.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMMeTableViewController.h"

@interface HMMeTableViewController ()<XMPPvCardTempModuleDelegate>
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

//获取内存存储
@property (nonatomic , strong)XMPPvCardTemp *myvCardTemp;

@end

@implementation HMMeTableViewController

//懒加载获取内存数据
-(XMPPvCardTemp *)myvCardTemp
{
    if (_myvCardTemp == nil) {
        _myvCardTemp = [HMManagerStream shareMananger].xmppvCardTempMoudle.myvCardTemp;
    }
    return _myvCardTemp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置代理
    [[HMManagerStream shareMananger].xmppvCardTempMoudle addDelegate:self delegateQueue:dispatch_get_main_queue()];
    //设置参数
    [self update];
}

//设置参数
- (void)update
{
    //头像
    self.icon.image = [UIImage imageWithData:self.myvCardTemp.photo];
    //名字
    self.name.text = [HMManagerStream shareMananger].xmppStream.myJID.bare;
    //昵称
    self.nickname.text = self.myvCardTemp.nickname;
    //个性签名
    self.desc.text = self.myvCardTemp.desc;
}


-(void)xmppvCardTempModuleDidUpdateMyvCard:(XMPPvCardTempModule *)vCardTempModule
{
    //清楚之前的内存存储
    self.myvCardTemp = nil;
    
    //重新赋值最新的数据
    [self update];
}


@end
