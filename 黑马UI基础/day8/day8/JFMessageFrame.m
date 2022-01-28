//
//  JFMessageFrame.m
//  day8
//
//  Created by 翟佳阳 on 2021/9/16.
//

#import "JFMessageFrame.h"
#import "JFMessage.h"
#import <UIKit/UIKit.h>
#import "NSString+JFNSStringExt_.h"
@implementation JFMessageFrame
- (void)setMessage:(JFMessage *)message{
    _message = message;
    //计算每个控件的frame和行高
    CGFloat margin = 10;
    //获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //时间
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenW;
    CGFloat timeH = 15;
    //当时间一致，不需要隐藏，才计算时间lable的frame
    if(!message.ishideTime){
    _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }
    //头像
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    CGFloat iconY = CGRectGetMaxY(_timeFrame) + margin;
    CGFloat iconX = message.type == JFMessageTypeOther? margin : screenW - margin - iconW;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //正文
    //先计算正文的大小
    CGSize textSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(300, MAXFLOAT) font:textFont];
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    //计算x,y
    CGFloat textY = iconY + margin;
    CGFloat textX = message.type == JFMessageTypeOther ? CGRectGetMaxX(_iconFrame) + margin : (screenW - margin * 2 - iconW - textW);
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    //行高
    //MAX一个宏，会返回最大的数
    CGFloat maxY = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame));
    _rowHight = maxY + margin;
}
@end
