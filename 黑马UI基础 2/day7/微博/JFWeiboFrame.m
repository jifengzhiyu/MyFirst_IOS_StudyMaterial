//
//  JFWeiboFrame.m
//  微博
//
//  Created by 翟佳阳 on 2021/9/16.
//

#import "JFWeiboFrame.h"
#import "JFWeibo.h"
@implementation JFWeiboFrame

//重写weibo属性的set方法
- (void)setWeibo:(JFWeibo *)weibo{
    _weibo = weibo;
    
    //计算每个控件的frame，单元格的行高
    //统一设置间距
    CGFloat margin = 10;
    
    //1、头像
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //2、昵称
    //获取昵称字符串
    NSString *nickName = weibo.name;
    CGFloat nameX = CGRectGetMaxX(_iconFrame) + margin;
    
    //获取字体字典
    //NSDictionary *attr = @{NSFontAttributeName : nameFont};
    //根据lable文字的内容，动态计算lable的宽和高
    CGSize nameSize = [self sizeWithText:nickName andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:nameFont];
    //不设置最大尺寸，就这么写
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    CGFloat nameY =  iconY + (iconH - nameH) / 2;
    _nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //3、会员
    CGFloat vipW = 10;
    CGFloat vipH = 10;
    CGFloat vipX = CGRectGetMaxX(_nameFrame) + margin;
    CGFloat vipY = nameY;
    _vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    
    //4、正文
    CGFloat textX = iconX;
    CGFloat textY = margin + CGRectGetMaxY(_iconFrame);
    CGSize textSize = [self sizeWithText:weibo.text andMaxSize:CGSizeMake(350, MAXFLOAT) andFont:textFont];
    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    //5、配图
    CGFloat picW = 100;
    CGFloat picH = 100;
    CGFloat picX = iconX;
    CGFloat picY = CGRectGetMaxY(_textFrame) + margin;
    _picFrame = CGRectMake(picX, picY, picW, picH);
    
    //6、计算每行的高度
    CGFloat rowHight = 0;
    if(self.weibo.picture){
        //如果有配图，计算行高
        rowHight = CGRectGetMaxY(_picFrame) + margin;
    }else{
        rowHight = CGRectGetMaxY(_textFrame) + margin;
    }
    //NSLog(@"%f",rowHight);
    _rowHeight = rowHight;
}

///根据给定的字符串，最大值的size，给定的字体，来计算文字的尺寸
- (CGSize)sizeWithText: (NSString *)text andMaxSize:(CGSize)maxSize andFont:(UIFont *)font{
    
    NSDictionary *attr = @{NSFontAttributeName: font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
@end
