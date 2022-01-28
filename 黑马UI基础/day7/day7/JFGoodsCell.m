//
//  JFGoodsCell.m
//  day7
//
//  Created by 翟佳阳 on 2021/9/14.
//

#import "JFGoodsCell.h"
#import "JFGoods.h"
@interface JFGoodsCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblBuyCount;


@end

@implementation JFGoodsCell
//重写setter
-(void)setGoods:(JFGoods *)goods{
    _goods = goods;
    //把模型数据设置给子控件
    self.imgViewIcon.image = [UIImage imageNamed:goods.icon];
    self.lblPrice.text = [NSString stringWithFormat:@"$ %@",goods.price];
    self.lblTitle.text = goods.title;
    self.lblBuyCount.text = [NSString stringWithFormat:@"%@ 人已购买",goods.buyCount];
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//封装一个自定义cell的方法
+ (instancetype)goodsCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"goods_cell";
    JFGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JFGoodsCell" owner:nil options:nil] firstObject];
}
    return cell;
}
@end
