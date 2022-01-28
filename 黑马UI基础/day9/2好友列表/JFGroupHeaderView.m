//
//  JFGroupHeaderView.m
//  2好友列表
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import "JFGroupHeaderView.h"
#import "JFGroup.h"
#import "JFGroupHeaderView.h"
@interface JFGroupHeaderView ()

@property (nonatomic, weak) UIButton *btnGroupTitle;
@property (nonatomic, weak) UILabel *lblCount;

@end

@implementation JFGroupHeaderView

//封装一个类方法来创建HeaderView
+ (instancetype)groupHeaderViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"group_header_view";
    JFGroupHeaderView *headerVw = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if(headerVw == nil){
        headerVw = [[JFGroupHeaderView alloc] initWithReuseIdentifier:ID];
    }
    headerVw.contentView.backgroundColor = [UIColor greenColor];
    return headerVw;
}

//重写initWithReuseIdentifer
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithReuseIdentifier:reuseIdentifier]){
        //创建按钮
        UIButton *btnGroupTitle = [[UIButton alloc] init];
        [self.contentView addSubview:btnGroupTitle];
        self.btnGroupTitle = btnGroupTitle;
        //[btnGroupTitle setImage:[UIImage imageNamed:@"34"] forState:UIControlStateNormal];
        //设置按钮文字的颜色
        [btnGroupTitle setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        //设置按钮文字的水平距离
        //设置按钮内容左对齐
        btnGroupTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置按钮内容的内边距
        btnGroupTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //为按钮添加一个点击事件
        [btnGroupTitle addTarget:self action:@selector(btnGroupTitleClicked) forControlEvents:UIControlEventTouchUpInside];
        
        //创建lable
        UILabel *lblCount = [[UILabel alloc] init];
        [self.contentView addSubview:lblCount];
        self.lblCount = lblCount;
    }
    return self;
}

//组标题按钮的点击事件
- (void)btnGroupTitleClicked{
    //1、设置组的状态
    //点击会切换 与之前相反的状态
    self.group.isVisible = !self.group.isVisible;
    
    //2、刷新tableView 使用代理方法
    if([self.delegate respondsToSelector:@selector(groupHeaderViewDidClickTitleButton:)]){
        //调用代理方法
        [self.delegate groupHeaderViewDidClickTitleButton:self];
    }
}

//重写group属性的set方法
- (void)setGroup:(JFGroup *)group{
    _group = group;
    //设置数据
    
    //设置按钮上的文字
    [self.btnGroupTitle setTitle:group.name forState:UIControlStateNormal];
    //设置标签上的文字
    self.lblCount.text = [NSString stringWithFormat:@"%d / %lu",group.online,group.friends.count];
    //设置frame,别写在这里，因为获取当前控件的宽和高都是0
    
}

///当 当前控件的frame发生改变时会调用这个方法
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
self.btnGroupTitle.frame = self.bounds;


CGFloat lblW = 100;
CGFloat lblH = self.bounds.size.height;
CGFloat lblX = self.bounds.size.width - 10 - lblW;
CGFloat lblY = 0;
self.lblCount.frame = CGRectMake(lblX, lblY, lblW, lblH);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
