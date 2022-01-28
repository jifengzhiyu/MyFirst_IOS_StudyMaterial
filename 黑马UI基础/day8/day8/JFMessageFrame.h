//
//  JFMessageFrame.h
//  day8
//
//  Created by 翟佳阳 on 2021/9/16.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#define textFont [UIFont systemFontOfSize:14]

//CG使用必须引进的框架，头文件
@class JFMessage;
NS_ASSUME_NONNULL_BEGIN

@interface JFMessageFrame : NSObject
//引用数据模型
@property (nonatomic, strong)JFMessage *message;
@property(nonatomic, assign, readonly)CGRect timeFrame;
@property(nonatomic, assign, readonly)CGRect iconFrame;
@property(nonatomic, assign, readonly)CGRect textFrame;
@property(nonatomic, assign, readonly)CGFloat rowHight;
@end
NS_ASSUME_NONNULL_END
