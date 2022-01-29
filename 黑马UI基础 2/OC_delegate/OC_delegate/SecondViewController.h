//
//  SecondViewController.h
//  SecondViewController
//
//  Created by Huawei on 2021/9/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PaymentVCDelegate <NSObject>

@required
- (void)orderChangeToPaidState;

@end

@class ViewController;
@interface SecondViewController : UIViewController

//@property (nonatomic, strong) ViewController * firstVC;

@property (nonatomic, weak) id<PaymentVCDelegate> delegate;
// 耦合性很高
// 设计模式 代理者

@end

NS_ASSUME_NONNULL_END
