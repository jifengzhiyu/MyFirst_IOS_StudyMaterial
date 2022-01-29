//
//  NSString+sandBox.m
//  获取沙盒目录
//
//  Created by 翟佳阳 on 2021/10/24.
//

#import "NSString+sandBox.h"

@implementation NSString (sandBox)
- (instancetype)appendCache{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)appendTemp{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self lastPathComponent]];
}
- (instancetype)appendDocument{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:[self lastPathComponent]];

}
@end
