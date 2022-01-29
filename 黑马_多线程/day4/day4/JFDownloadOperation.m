//
//  JFDownloadOperation.m
//  day4
//
//  Created by 翟佳阳 on 2021/10/25.
//

#import "JFDownloadOperation.h"
#import "NSString+sandBox.h"
@implementation JFDownloadOperation
- (void)main{
    @autoreleasepool {
        //断言，来提示错误
        NSAssert(self.finishedBlock != nil, @"finishedBlock can not be nil");
        
        [NSThread sleepForTimeInterval:2.0];
        
        //下载图片
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //缓存到沙盒
        if(data){
            [data writeToFile:[self.urlString appendCache] atomically:YES];
        }
        
        //使进入耗时的操作也被取消
        if(self.isCancelled){
            return;
        }
        NSLog(@"下载图片--%@--%@",[NSThread currentThread],self.urlString);
//        //图片下载完成，更新ui
//        //手动回调方法
////        if(self.finishedBlock){
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                self.finishedBlock(self.urlString);
//            }];
////        }
        //回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIImage *img = [UIImage imageWithData:data];
            self.finishedBlock(img);
        }];
    }
}
+(instancetype)downloaderOperationWithURLString:(NSString *)urlString finishedBlcok:(void(^)(UIImage *img))finishedBlock{
    JFDownloadOperation *op = [[JFDownloadOperation alloc] init];
    op.urlString = urlString;
    op.finishedBlock = finishedBlock;
    return op;
}
@end
