//
//  JFDownloadOperation.h
//  day4
//
//  Created by 翟佳阳 on 2021/10/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface JFDownloadOperation : NSOperation
//图片地址
@property (nonatomic, copy) NSString *urlString;
//下载完毕后，回调的block
@property (nonatomic, copy) void(^finishedBlock)(UIImage *img);
+(instancetype)downloaderOperationWithURLString:(NSString *)urlString finishedBlcok:(void(^)(UIImage *img))finishedBlock;
@end

NS_ASSUME_NONNULL_END
