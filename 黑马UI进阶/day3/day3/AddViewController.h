//
//  AddViewController.h
//  day3
//
//  Created by 翟佳阳 on 2021/10/1.
//


#import <UIKit/UIKit.h>
#import "Contact.h"
@class AddViewController;
NS_ASSUME_NONNULL_BEGIN

@protocol AddViewControllerDelegate <NSObject>

@optional
- (void)addViewController:(AddViewController *)addViewController withContact:(Contact *)contact; 

@end


@interface AddViewController : UIViewController
@property (nonatomic, weak)id<AddViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
