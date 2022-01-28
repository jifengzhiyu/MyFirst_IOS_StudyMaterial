//
//  ITCASTProductCell.m
//  06网易彩票
//
//  Created by teacher on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "ITCASTProductCell.h"
#import "ITCASTProduct.h"
@interface ITCASTProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end


@implementation ITCASTProductCell

- (void)setProduct:(ITCASTProduct *)product
{
    _product = product;
    // 把模型中的数据赋值给子控件
    self.imgViewIcon.image = [UIImage imageNamed:product.icon];
    self.lblName.text = product.title;
}

- (void)awakeFromNib
{
    self.imgViewIcon.layer.cornerRadius = 10;
    self.imgViewIcon.layer.masksToBounds = YES;
}


@end
