//
//  HMdetailTableViewController.m
//  黑马微信
//
//  Created by apple on 16/2/28.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMdetailTableViewController.h"

@interface HMdetailTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,XMPPvCardTempModuleDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@property(nonatomic,strong)XMPPvCardTemp *xmppvCardTemp;

@end

@implementation HMdetailTableViewController

//懒加载
-(XMPPvCardTemp *)xmppvCardTemp
{
    if (_xmppvCardTemp == nil) {
        _xmppvCardTemp = [HMManagerStream shareMananger].xmppvCardTempMoudle.myvCardTemp;
    }
    return _xmppvCardTemp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //代理设置
    [[HMManagerStream shareMananger].xmppvCardTempMoudle addDelegate:self delegateQueue:dispatch_get_main_queue()];
    //数据显示
    
    [self update ];
}

- (void)update
{
    self.icon.image = [UIImage imageWithData:self.xmppvCardTemp.photo];
    
    self.nickname.text = self.xmppvCardTemp.nickname;
    
    self.desc.text = self.xmppvCardTemp.desc;
}

//换头像
- (IBAction)pickerImage:(id)sender {
    
    //相册
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    //参数设置
    picker.allowsEditing = YES;
    
    //设置代理
    picker.delegate = self;
    
    //弹出控制器
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

//选中了哪个图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //获取头像
    NSLog(@"info   = %@",info);
    //获取图片
       UIImage *image =  info[UIImagePickerControllerEditedImage];
        NSData *imgdata =  UIImageJPEGRepresentation(image, 0.2);
    
    //内存存储
    self.xmppvCardTemp.photo = imgdata;
    
    //数据更新
    [[HMManagerStream shareMananger].xmppvCardTempMoudle updateMyvCardTemp:self.xmppvCardTemp];
    
    //控制器dismiss
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

//取消选中图片
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)xmppvCardTempModuleDidUpdateMyvCard:(XMPPvCardTempModule *)vCardTempModule
{
    //数据重新赋值
    //1.清楚之前的内存存储
    self.xmppvCardTemp = nil;
    
    //2.重新赋值
    [self update];
}

//跳转传参数
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"desc"]) {
        segue.destinationViewController.title = @"个性签名";
    }else
    {
        segue.destinationViewController.title = @"昵称";
    }
}

@end
