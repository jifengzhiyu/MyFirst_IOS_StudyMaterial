//
//  NSString+sandBox.h
//  获取沙盒目录
//
//  Created by 翟佳阳 on 2021/10/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (sandBox)
- (instancetype)appendCache;
- (instancetype)appendTemp;
- (instancetype)appendDocument;

@end

NS_ASSUME_NONNULL_END
