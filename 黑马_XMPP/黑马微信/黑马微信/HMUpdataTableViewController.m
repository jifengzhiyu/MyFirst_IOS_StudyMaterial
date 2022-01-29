//
//  HMUpdataTableViewController.m
//  黑马微信
//
//  Created by apple on 16/2/28.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMUpdataTableViewController.h"

@interface HMUpdataTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textMessage;

@property(nonatomic,strong)XMPPvCardTemp *myvCardTemp;

@end

@implementation HMUpdataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(XMPPvCardTemp *)myvCardTemp
{
    if (_myvCardTemp == nil) {
        _myvCardTemp = [HMManagerStream shareMananger].xmppvCardTempMoudle.myvCardTemp;
    }
    return _myvCardTemp;
}

//取消
- (IBAction)cancelButton:(id)sender {
    //pop出这个控制器 回到上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}


//数据更新确认
- (IBAction)updatacornect:(id)sender {
    //数据更新
    if ([self.title isEqualToString:@"昵称"]) {
        //对昵称做一个更新
        self.myvCardTemp.nickname = self.textMessage.text;
    }else
    {//个性签名
        self.myvCardTemp.desc = self.textMessage.text;
    }
    
    //更新数据
    [[HMManagerStream shareMananger].xmppvCardTempMoudle updateMyvCardTemp:self.myvCardTemp];
    
    //pop出这个控制器 回到上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}


@end
