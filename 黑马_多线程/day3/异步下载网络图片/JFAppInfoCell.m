//
//  JFAppInfoCell.m
//  异步下载网络图片
//
//  Created by 翟佳阳 on 2021/10/23.
//

#import "JFAppInfoCell.h"
#import "MyAppInfo.h"
@interface JFAppInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *downloadView;


@end
@implementation JFAppInfoCell

- (void)setAppInfo:(MyAppInfo *)appInfo{
    _appInfo = appInfo;
    self.nameView.text = appInfo.name;
    self.downloadView.text = appInfo.download;
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
