//
//  Player.h
//  猜拳游戏
//
//  Created by 翟佳阳 on 2021/8/4.
//

/*
 玩家类：
 属性：姓名，出的拳头（枚举），得分
 方法：出拳行为，用户选择
 */
#import <Foundation/Foundation.h>
#import "FistType.h"
NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject
{
    @public
    NSString*_name;
    int _score;
    FistType _selectedType;
}

- (void)showFist;

/// 要取出整形的数代表字符串的拳头类型
/// @param number 枚举的值
- (NSString*)fistTypeWithNumber:(int)number;

@end



NS_ASSUME_NONNULL_END
