//
//  EditUIViewController.h
//  day3
//
//  Created by 翟佳阳 on 2021/10/1.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
@class EditUIViewController;
NS_ASSUME_NONNULL_BEGIN
@protocol EditViewControllerDelegata <NSObject>

@optional
- (void)editViewController:(EditUIViewController *)editViewController withContact:(Contact *)contact;

@end



@interface EditUIViewController : UIViewController
@property (nonatomic, strong) Contact *contact;
@property (nonatomic, weak) id<EditViewControllerDelegata>delegate;

@end

NS_ASSUME_NONNULL_END
