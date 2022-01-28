//
//  DanJia.m
//  士兵突击
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import "DanJia.h"

@implementation DanJia
- (void)setMaxCapcity:(int)maxCapcity{
    _maxCapcity = maxCapcity;
}
- (int)macCapcity{
    return _maxCapcity;
}

- (void)setBulletCount:(int)bulletcount{
    if(bulletcount >= 0 && bulletcount <= _maxCapcity){
    _bulletCout = bulletcount;
    }else{
        _bulletCout = 1;
    }
}
- (int)bulletCount{
    return _bulletCout;
}
@end
