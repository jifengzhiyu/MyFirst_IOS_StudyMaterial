//
//  JFAppCell.m
//  3自定义模版_应用管理
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import "JFAppCell.h"
#import "JFApp.h"
@interface JFAppCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblIntro;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;
- (IBAction)btnDownloadClick;


@end
@implementation JFAppCell

- (void)setApp:(JFApp *)app{
    _app = app;
    //把模型中的数据，设置给单元格的子控件
    self.imageView.image = [UIImage imageNamed:app.icon];
    self.lblName.text = app.name;
    self.lblIntro.text = [NSString stringWithFormat:@"大小：%@ | 下载量： %@",app.size,app.download];
    
    //更新下载按钮的状态（避免重用单元格导致的问题
    if(app.isDownloaded){
        self.btnDownload.enabled = NO;
    }else{
        self.btnDownload.enabled = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

///下载按钮的点击事件
- (IBAction)btnDownloadClick {
    //1、禁用按钮
    self.btnDownload.enabled = NO;
    self.app.isDownloaded = YES;
    
    //2、弹出消息提示label
    if([self.delegate respondsToSelector:@selector(appCellDidClickDownloadButton:)]){
        [self.delegate appCellDidClickDownloadButton:self];
    }
}
@end
