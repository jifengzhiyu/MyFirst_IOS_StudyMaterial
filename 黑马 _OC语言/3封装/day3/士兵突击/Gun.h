//
//  Gun.h
//  士兵突击
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "DanJia.h"
NS_ASSUME_NONNULL_BEGIN
/*
 枪类：
 属性：型号，射击
 行为：射击
 */
@interface Gun : NSObject
{
    NSString* _model;
    int _sheCheng;
    //int _bulletCount;//子弹数量
    DanJia* _danJia;
}

- (void)setModel:(NSString*)model;
- (NSString*)model;

- (void)setSheCheng:(int)sheCheng;
- (int)sheCheng;

- (void)setDanJia:(DanJia*)danjia;
- (DanJia*)danjia;

//- (void)setBulletCount:(int)bulletCount;
//- (int)bulletCount;

- (void)shoot;
@end

NS_ASSUME_NONNULL_END
