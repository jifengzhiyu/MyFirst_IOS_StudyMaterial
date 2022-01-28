//
//  ContactViewController.h
//  day3
//
//  Created by 翟佳阳 on 2021/9/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactViewController : UITableViewController
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) NSMutableArray *contacts;

@end

NS_ASSUME_NONNULL_END
