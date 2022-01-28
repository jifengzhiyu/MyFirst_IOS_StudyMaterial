//
//  NSString+JFNSStringExt_.m
//  day8
//
//  Created by 翟佳阳 on 2021/9/17.
//

#import "NSString+JFNSStringExt_.h"

@implementation NSString (JFNSStringExt_)
-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font{
    NSDictionary *attrs = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}
@end
