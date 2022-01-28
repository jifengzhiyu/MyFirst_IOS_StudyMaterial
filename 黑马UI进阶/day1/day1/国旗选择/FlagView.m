//
//  FlagView.m
//  国旗选择
//
//  Created by 翟佳阳 on 2021/9/26.
//

#import "FlagView.h"
#import "Flag.h"
@interface FlagView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@end

@implementation FlagView
 

- (void)setFlag:(Flag *)flag{
    _flag = flag;
    
    //设置数据
    self.nameLbl.text = flag.name;
    self.iconView.image = [UIImage imageNamed:flag.icon];
}

+(instancetype)flagView{
    return [[[NSBundle mainBundle] loadNibNamed:@"FlagView" owner:nil options:nil] lastObject];
}

+ (CGFloat)rowHeight{
    return 55;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
