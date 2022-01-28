//
//  AppView.h
//  day3
//
//  Created by 翟佳阳 on 2021/9/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class APP;//相当于inport
@interface AppView : UIView

@property(nonatomic,strong)APP * modle;
//为自定义view封装一个类方法，作用是创建一个view对象
+(instancetype)appView;


@end

NS_ASSUME_NONNULL_END
