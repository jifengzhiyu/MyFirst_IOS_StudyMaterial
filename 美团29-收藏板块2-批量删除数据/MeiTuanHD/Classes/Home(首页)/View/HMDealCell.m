//
//  HMDealCell.m
//  MeiTuanHD
//
//  Created by apple on 16/3/6.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMDealCell.h"
#import "HMDealModel.h"

@interface HMDealCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dealNewImageView;
@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;

@end

@implementation HMDealCell

#pragma mark 重写 set 方法
- (void)setDealModel:(HMDealModel *)dealModel
{
    _dealModel = dealModel;
    
    //1. 图像
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dealModel.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    
    //2. 标题
    self.titleLabel.text = dealModel.title;
    
    //3. 详情
    self.descLabel.text = dealModel.desc;
    
    //4. 当前价格
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %@", dealModel.current_price];
    
    /**
     判断, 小数点的位置 跟总长度比较
     
     9.99     1          4
     9.990    1          5
     
     总长度 - 小数点的位置 > 3 需要截取
     */
    //4.1 查找小数点位置
    //rangeOfString: 传入一个字符串, 返回对应的range(location, length)
    NSInteger currentPriceLocation = [self.currentPriceLabel.text rangeOfString:@"."].location;
    
    //4.2 判断有没有找到小数点位置
    //NSNotFound = NSIntegerMax
    if (currentPriceLocation != NSNotFound) {
        
        //4.3 如果找到了小数点位置 总长度 - 小数点的位置 > 3 需要截取
        if (self.currentPriceLabel.text.length - currentPriceLocation > 3) {
            
            //4.4 重新赋值: 将字符串转换层 float 类型, 再赋值
            self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f", [dealModel.current_price floatValue]];
        }
    }
    
    
    
    
    //5. 原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥ %@", dealModel.list_price];
    
    //5.1 查找小数点位置
    NSInteger listPriceLocation = [self.listPriceLabel.text rangeOfString:@"."].location;
    
    //5.2 判断有没有找到小数点位置
    if (listPriceLocation != NSNotFound) {
        
        //5.3 如果找到了小数点位置
        if (self.listPriceLabel.text.length - listPriceLocation > 3) {
            
            //5.4 重新赋值: 将字符串转换层 float 类型, 再赋值
            self.listPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f", [dealModel.list_price floatValue]];
        }
    }
    
    //6. 已售
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售: %zd", dealModel.purchase_count];
    
    //7. 新单的显示
    //获取当前的日期
    //模型日期: 2020-12-01
    
    //7.1 获取当前的日期
    NSDate *date = [NSDate date];
    
    //7.2 创建日期格式化的类
    NSDateFormatter * fmt = [NSDateFormatter new];
    
    //7.3 设置转换的格式
    fmt.dateFormat = @"yyyy-MM-dd";
    
    //7.4 将日期转换成字符串
    NSString *dateStr = [fmt stringFromDate:date];
    
    //7.5 比较2个字符串
    // 隐藏: 当前日期 > 发布日期  == YES
    self.dealNewImageView.hidden = [dateStr compare:dealModel.publish_date ] == NSOrderedDescending;
    
    //8. 遮盖按钮的显示与隐藏
    // 隐藏 == 不编辑
    self.coverButton.hidden = !dealModel.editting;
    
    //9. 打钩图像的显示与隐藏
    self.chooseImageView.hidden = !dealModel.choose;
}

#pragma mark 遮盖按钮点击 --> 打钩图像的显示
- (IBAction)coverButtonClick:(id)sender {
    //1. 更改图像的隐藏与显示
    self.chooseImageView.hidden = !self.chooseImageView.hidden;
    
    //2. 更改模型 --> MVC -->更改模型就能更改界面
    self.dealModel.choose = !self.dealModel.isChoose;
    
    //3. 调用 block
    if (self.dealCellDidClickBlock) {
        self.dealCellDidClickBlock();
    }
}

@end
