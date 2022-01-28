//
//  JFFooterView.h
//  day7
//
//  Created by 翟佳阳 on 2021/9/15.
//

#import <UIKit/UIKit.h>
@class JFFooterView;
NS_ASSUME_NONNULL_BEGIN


@protocol JFFooterViewDelegate <NSObject>
@required
- (void)footerViewUpdateData:(JFFooterView *)footerView;
//代理协议里的方法以代理协议名称开头，必须有一个参数（控件自己）
//协议里面访问不到JFFooterView,需要@class
@end

@interface JFFooterView : UIView
@property(nonatomic,weak)id<JFFooterViewDelegate>delegate;
//UI控件的代理属性，id是属性类型，属性要遵守代理协议，delegate是属性名字，如果需要代理的是UI控件，代理属性必须是weak

+ (instancetype)footerView;
@end

NS_ASSUME_NONNULL_END
