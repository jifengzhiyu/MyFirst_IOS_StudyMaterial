//
//  HMBaseCollectionViewController.h
//  MeiTuanHD
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMBaseCollectionViewController : UICollectionViewController

/**
 父类提供了一个方法 --> 子类也会有此方法
 */

- (void)setParams:(NSMutableDictionary *)params;

///** 提供一个方法/属性, 告诉公用控制器, 是否需要首次刷新*/
//@property (nonatomic, assign) BOOL needFirstFefresh;

@end
