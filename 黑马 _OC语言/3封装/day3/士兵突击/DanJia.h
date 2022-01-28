//
//  DanJia.h
//  士兵突击
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DanJia : NSObject
{
    int _maxCapcity;//弹夹能装最多的子弹
    int _bulletCout;//弹夹现在多少发子弹
}
- (void)setMaxCapcity:(int)maxCapcity;
- (int)macCapcity;

- (void)setBulletCount:(int)bulletcount;
- (int)bulletCount;
@end

NS_ASSUME_NONNULL_END
