//
//  Judge.h
//  猜拳游戏
//
//  Created by 翟佳阳 on 2021/8/4.
//

/*
 裁判类：
 属性：姓名
 方法：判断输赢，分数
 */
#import <Foundation/Foundation.h>
#import "Robot.h"
#import "Player.h"
NS_ASSUME_NONNULL_BEGIN

@interface Judge : NSObject
{
    @public
    NSString* _name;
}



/// 裁判裁决
/// @param player 用户
/// @param robot 机器人
- (void)caiJueWithPlayer:(Player*)player andRobot:(Robot*)robot;

@end
NS_ASSUME_NONNULL_END
