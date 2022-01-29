//
//  JFFriendCell.m
//  2好友列表
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import "JFFriendCell.h"
#import "JFFriend.h"
@implementation JFFriendCell

+(instancetype)friendCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"friend_cell";
    JFFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[JFFriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setFriendModel:(JFFriend *)friendModel{
    _friendModel = friendModel;
    //把模型中的数据设置给单元格的子控件
    self.imageView.image = [UIImage imageNamed:friendModel.icon];
    self.textLabel.text = friendModel.name;
    //根据是否是vip设置字体颜色
    self.textLabel.textColor = friendModel.isVip ? [UIColor redColor] : [UIColor blackColor];
    
    self.detailTextLabel.text = friendModel.intro;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
