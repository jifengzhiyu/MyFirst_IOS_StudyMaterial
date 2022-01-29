//
//  HMAudioTools.h
//  01-音效
//
//  Created by dream on 15/12/23.
//  Copyright © 2015年 dream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface HMAudioTools : NSObject

/** 播放系统音效*/
+ (void)playSystemSoundWithURL:(NSURL *)url;

/** 播放震动音效*/
+ (void)playAlertSoundWithURL:(NSURL *)url;

/** 清空音效文件的内存*/
+ (void)clearMemory;

@end
