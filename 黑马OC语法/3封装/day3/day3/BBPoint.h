//
//  BBPoint.h
//  day3
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBPoint : NSObject
{
    @public
    int _x;
    int _y;
}

//计算当前的点和另外的点距离
- (double)distanceWithOtherPoint: (BBPoint*)otherPoint;
@end

NS_ASSUME_NONNULL_END
