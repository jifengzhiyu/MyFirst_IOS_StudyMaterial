//
//  JFWeiboCellTableViewCell.m
//  微博
//
//  Created by 翟佳阳 on 2021/9/15.
//

#import "JFWeiboCell.h"
#import "JFWeibo.h"
#import "JFWeiboFrame.h"
//设置字体多次用到，设置为宏
//字体：系统字体12大小



@interface JFWeiboCell ()
@property(nonatomic,weak)UIImageView *imgViewIcon;
@property(nonatomic,weak)UILabel *lblNickName;
@property(nonatomic,weak)UIImageView *imgViewVip;
@property(nonatomic,weak)UILabel *lblText;
@property(nonatomic,weak)UIImageView *imgViewPicture;
@end



@implementation JFWeiboCell

+ (instancetype)weiboCellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"weibo_cell";
    JFWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[JFWeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


#pragma mark - 重写单元格的initWithStyle:方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    
    //创建5个子控件
    //1、头像
    UIImageView *imgViewIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        
    //2、昵称
    UILabel *lblNickName = [[UILabel alloc] init];
        //设置lable文字大小
        lblNickName.font = nameFont;
    [self.contentView addSubview:lblNickName];
        self.lblNickName = lblNickName;
        
    //3、会员
    UIImageView *imgViewVip = [[UIImageView alloc] init];
        //3、会员：因为都一样，不要反复创建
        imgViewVip.image = [UIImage imageNamed:@"0"];
    [self.contentView addSubview:imgViewVip];
        self.imgViewVip = imgViewVip;
    
    //4、正文
    UILabel *lblText = [[UILabel alloc] init];
        lblText.font = textFont;
        //设置自动换行
        lblText.numberOfLines = 0;
    [self.contentView addSubview:lblText];
        self.lblText = lblText;
    
    //5、配图
    UIImageView *imgViewPicture = [[UIImageView alloc] init];
    [self.contentView addSubview:imgViewPicture];
    self.imgViewPicture = imgViewPicture;
        
    }
    return self;
}

#pragma mark - 重写weibo属性的setter

- (void)setWeiboFrame:(JFWeiboFrame *)weiboFrame{
    
    _weiboFrame = weiboFrame;
    //1、设置当前单元格中的子控件的数据
    [self settingData];
    //2、设置当前单元格中子控件的frame
    [self settingFrame];
    
}

///设置数据的方法
- (void)settingData{
    JFWeibo *model = self.weiboFrame.weibo;
    //1、头像
    self.imgViewIcon.image = [UIImage imageNamed:model.icon];
    
    //2、昵称
    self.lblNickName.text = model.name;
    
    //3、会员：因为都一样，不要反复创建
    if(model.isVip){
        self.imgViewVip.hidden = NO;
        self.lblNickName.textColor = [UIColor redColor];
    }else{
        self.imgViewVip.hidden = YES;
        self.lblNickName.textColor = [UIColor blackColor];
    }
    
    //4、正文
    self.lblText.text = model.text;
    
    //5、配图
    if(model.picture){
        self.imgViewPicture.image = [UIImage imageNamed:model.picture];
        self.imgViewPicture.hidden = NO;
    }else{
        self.imageView.hidden = YES;
        //双重判断，避免单元格重用时，没有把之前的数据更改，直接使用
    }
}

///设置frame的方法
- (void)settingFrame{
  
    //1、头像
    self.imgViewIcon.frame = self.weiboFrame.iconFrame;
    //2、昵称
    self.lblNickName.frame = self.weiboFrame.nameFrame;
    
    //3、会员
    self.imgViewVip.frame = self.weiboFrame.vipFrame;
    
    //4、正文
    self.lblText.frame = self.weiboFrame.textFrame;
    
    //5、配图
    self.imgViewPicture.frame = self.weiboFrame.picFrame;
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
