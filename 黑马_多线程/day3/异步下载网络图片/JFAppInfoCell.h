//
//  JFAppInfoCell.h
//  异步下载网络图片
//
//  Created by 翟佳阳 on 2021/10/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MyAppInfo;

@interface JFAppInfoCell : UITableViewCell
@property (nonatomic, strong) MyAppInfo *appInfo;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;



@end

NS_ASSUME_NONNULL_END
