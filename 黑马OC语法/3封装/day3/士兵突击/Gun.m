//
//  Gun.m
//  士兵突击
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import "Gun.h"

@implementation Gun
- (void)setModel:(NSString*)model{
    _model = model;
}
- (NSString*)model{
    return _model;
}

- (void)setSheCheng:(int)sheCheng{
    _sheCheng = sheCheng;
}
- (int)sheCheng{
    return _sheCheng;
}

//- (void)setBulletCount:(int)bulletCount{
//    _bulletCount = bulletCount;
//}
//- (int)bulletCount{
//    return _bulletCount;
//}

- (void)shoot{
    //1、判断是否有子弹
    if([_danJia bulletCount] > 0){
    NSLog(@"图兔兔图图.........");
        int count = [_danJia bulletCount];
        [_danJia setBulletCount:count--];
        NSLog(@"剩余子弹数量：%d",count);
    //2、子弹减1
    }else{
        NSLog(@"没有子弹了");
    }
}
- (void)setDanJia:(DanJia*)danjia{
    _danJia = danjia;
}
- (DanJia*)danjia{
    return _danJia;
}
@end
