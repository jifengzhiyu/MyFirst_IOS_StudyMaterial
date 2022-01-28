//
//  JFApp.h
//  3自定义模版_应用管理
//
//  Created by 翟佳阳 on 2021/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFApp : NSObject
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *download;
//增加用来标记是否下载过的一个属性
@property (nonatomic, assign) BOOL isDownloaded;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)AppWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
