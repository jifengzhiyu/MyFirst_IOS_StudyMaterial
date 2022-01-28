//
//  Player.m
//  猜拳游戏
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import "Player.h"

@implementation Player
///出拳
- (void)showFist{
    //1、提示选择
    NSLog(@"亲爱的玩家【%@】请选择你要出的拳头 1.剪刀 2.石头 3.布",_name);
    //2、接收选择
    int userSelect = 0;
    scanf("%d",&userSelect);
    //3、显示选择
    //要取出整形的数代表字符串的拳头类型
    NSString* type = [self fistTypeWithNumber:userSelect];
    //self当前对象,[self 方法名：参数]
    
    NSLog(@"玩家【%@】出的拳头是：%@",_name,type);
    //4、将用户出的拳头存储在当前对象属性中
    _selectedType = userSelect;
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
