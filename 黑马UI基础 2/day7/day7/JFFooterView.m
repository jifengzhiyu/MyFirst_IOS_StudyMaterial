//
//  JFFooterView.m
//  day7
//
//  Created by 翟佳阳 on 2021/9/15.
//

#import "JFFooterView.h"

@interface JFFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *btnLoadMore;
@property (weak, nonatomic) IBOutlet JFFooterView *waitingView;
- (IBAction)btnLoadMoreClick;





@end

@implementation JFFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnLoadMoreClick {
    //1、隐藏“加载更多”按钮
    self.btnLoadMore.hidden = YES;
    //2、显示“等待指示器”所在那个UIView
    self.waitingView.hidden = NO;
    
    //延迟一秒执行下面代码块
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //1、增加一条数据
        //2、刷新UITableView
        //上面两步合到代理方法里面，直接调用代理方法
        //调用代理方法之前，要确保代理对象已经实现了这个代理方法
        if([self.delegate respondsToSelector:@selector(footerViewUpdateData:)]){
        [self.delegate footerViewUpdateData:self];
        }
        //第二个self是当前控件

        //3、显示“加载更多”按钮
        self.btnLoadMore.hidden = NO;
        self.waitingView.hidden = YES;
    });

}

+ (instancetype)footerView{
    JFFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"JFFooterView" owner:nil options:nil] lastObject];
    return footerView; ;
}
@end
