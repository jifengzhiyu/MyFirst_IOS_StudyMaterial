//
//  JFJFHeaderView.m
//  day7
//
//  Created by 翟佳阳 on 2021/9/15.
//

#import "JFHeaderView.h"
@interface JFHeaderView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
@implementation JFHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//唤醒冰封的xib，xib加载之后就会立即自动调用这个方法，可以当viewDidLoad用
- (void)awakeFromNib{
    [super awakeFromNib];
    //在里面写图片轮播器，之前写在viewDidLoad里面的代码
}

+ (instancetype)headerView{
    //创建headerView
    JFHeaderView * headerView = [[[NSBundle mainBundle] loadNibNamed:@"JFHeaderView" owner:nil options:nil] lastObject];
    return headerView;
}
@end
