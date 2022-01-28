//
//  Robot.h
//  猜拳游戏
//
//  Created by 翟佳阳 on 2021/8/4.
//

/*
 机器人类：
 属性：姓名，拳头，得分
 方法：出拳，随机
 */
#import <Foundation/Foundation.h>
#import "FistType.h"
NS_ASSUME_NONNULL_BEGIN

@interface Robot : NSObject
{
    @public
    NSString* _name;
    FistType _selectedType;
    int _score;
}

- (void)showFist;
- (NSString*)fistTypeWithNumber:(int)number;
@end

NS_ASSUME_NONNULL_END
