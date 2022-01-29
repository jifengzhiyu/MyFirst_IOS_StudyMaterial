//
//  JFWeiboFrame.h
//  微博
//
//  Created by 翟佳阳 on 2021/9/16.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
//可以使用UIFont

#define nameFont [UIFont systemFontOfSize:12]
#define textFont [UIFont systemFontOfSize:14]

//这个头文件包括CGRect
NS_ASSUME_NONNULL_BEGIN
@class JFWeibo;
@interface JFWeiboFrame : NSObject
@property (nonatomic, strong) JFWeibo *weibo;

@property(nonatomic, assign, readonly) CGRect iconFrame;
@property(nonatomic, assign, readonly) CGRect nameFrame;
@property(nonatomic, assign, readonly) CGRect vipFrame;
@property(nonatomic, assign, readonly) CGRect textFrame;
@property(nonatomic, assign, readonly) CGRect picFrame;

//行高
@property(nonatomic, assign) CGFloat rowHeight;

@end

NS_ASSUME_NONNULL_END
