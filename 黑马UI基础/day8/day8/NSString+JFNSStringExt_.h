//
//  NSString+JFNSStringExt_.h
//  day8
//
//  Created by 翟佳阳 on 2021/9/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (JFNSStringExt_)
-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
