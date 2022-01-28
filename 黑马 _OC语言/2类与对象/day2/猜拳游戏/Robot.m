//
//  Robot.m
//  猜拳游戏
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import "Robot.h"
#import <stdlib.h>
@implementation Robot
- (void)showFist{
    //1、随机出拳
    int robotSelect =arc4random_uniform(3)+1;
    //2、显示随机出的拳头
    NSString* type = [self fistTypeWithNumber:robotSelect];
    NSLog(@"机器人[%@]出的拳头是：%@",_name,type);
    //3、把出的拳头保存在当前对象中
    _selectedType = robotSelect;
    
}
- (NSString*)fistTypeWithNumber:(int)number{
    
    switch (number) {
        case 1:
            return @"剪刀";
            break;
            
        case 2:
            return @"石头";
        default:
            return @"布";
            break;
    }
}
@end
