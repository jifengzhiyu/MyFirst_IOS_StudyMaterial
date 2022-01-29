//
//  JFMessageCell.m
//  day8
//
//  Created by 翟佳阳 on 2021/9/17.
//

#import "JFMessageCell.h"
#import "JFMessage.h"
#import "JFMessageFrame.h"
@interface JFMessageCell()

@property(nonatomic, weak)UILabel *lblTime;
@property(nonatomic, weak)UIImageView *imgViewIcon;
@property(nonatomic, weak)UIButton *btnText;

@end

@implementation JFMessageCell
///重写initWithStyle
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //创建子控件
        
        //显示时间的lable
        UILabel *lblTime = [[UILabel alloc] init];
        //设置文字大小
        lblTime.font = [UIFont systemFontOfSize:12];
        //设置文字居中
        lblTime.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:lblTime];
        self.lblTime = lblTime;
        
        //显示头像的UIImageView
        UIImageView *imgViewIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        
        //显示正文的按钮
        UIButton *btnText = [[UIButton alloc] init];
        //设置正文字体大小
        btnText.titleLabel.font = textFont;
        //修改按钮的文字颜色
        [btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置按钮内的文字可以换行
        btnText.titleLabel.numberOfLines = 0;
        
        
        [self.contentView addSubview:btnText];
        self.btnText = btnText;
    }
    //设置单元格的背景色是clearColor
    self.backgroundColor = [UIColor clearColor];
    return self;
}

///重写frame模型的setter
-(void)setMessageFrame:(JFMessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    //获取数据模型
    JFMessage *message = messageFrame.message;
    
    //给每一个控件设置数据 和 frame
    self.lblTime.text = message.time;
    self.lblTime.frame = messageFrame.timeFrame;
    self.lblTime.hidden = message.ishideTime;
    
    NSString *iconImg = message.type == JFMessageTypeMe ? @"0" : @"1";
    self.imgViewIcon.image = [UIImage imageNamed:iconImg];
    self.imgViewIcon.frame = messageFrame.iconFrame;
    
    [self.btnText setTitle:message.text forState:UIControlStateNormal];
    self.btnText.frame = messageFrame.textFrame;
    
    //设置正文的背景图
    NSString *imgNor, *imgHighlighted;
    if(message.type == JFMessageTypeMe){
        imgNor = @"41";
        imgHighlighted = @"42";
        //设置正文颜色白色
        [self.btnText setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }else{
        //对方发的消息
        imgNor = @"42";
        imgHighlighted = @"41";
        //设置正文颜色黑色
        [self.btnText setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    //加载图片
    UIImage *imageNormal = [UIImage imageNamed:imgNor];
    UIImage *imageHighlighted = [UIImage imageNamed:imgHighlighted];
    
    //用平铺的方式拉伸图片
    imageNormal = [imageNormal stretchableImageWithLeftCapWidth:imageNormal.size.width * 0.5 topCapHeight:imageNormal.size.height * 0.5];
    imageHighlighted = [imageHighlighted stretchableImageWithLeftCapWidth:imageHighlighted.size.width * 0.5 topCapHeight:imageHighlighted.size.height * 0.5];
    
    //设置正文背景图
    [self.btnText setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [self.btnText setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

///创建自定义cell类方法
+(instancetype)messageCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"message_cell";
    JFMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[JFMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
@end
