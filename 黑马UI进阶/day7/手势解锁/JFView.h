//
//  JFView.h
//  手势解锁
//
//  Created by 翟佳阳 on 2021/10/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFView : UIView

//让ViewController判断密码
@property (nonatomic, copy)  BOOL(^passwordBlock)(NSString *);

@end

NS_ASSUME_NONNULL_END
