//
//  MyAppInfo.h
//  异步下载网络图片
//
//  Created by 翟佳阳 on 2021/10/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MyAppInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *download;

//缓存图片,拿内存空间换取时间
//不然每次调用layoutSubviews（滚动，，，）时就要重新从网络获取
@property (nonatomic, strong) UIImage *image;



+(instancetype)appInfoWithDict:(NSDictionary *)dict;

//在这里面进行懒加载（各司其职
+ (NSArray *)appInfos;
@end

NS_ASSUME_NONNULL_END
