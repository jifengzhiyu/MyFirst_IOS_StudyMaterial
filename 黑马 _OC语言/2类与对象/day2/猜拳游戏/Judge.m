//
//  Judge.m
//  猜拳游戏
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import "Judge.h"

@implementation Judge
/// 裁判裁决
/// @param player 用户
/// @param robot 机器人
- (void)caiJueWithPlayer:(Player*)player andRobot:(Robot*)robot{
    
    //1、拿到玩家和机器人出的拳头
    FistType playerType = player->_selectedType;
    FistType robotType = robot->_selectedType;
    
    //2、判断，加分，显示
    /*
     利用枚举的编号
     剪刀1
     石头2
     布3
     
     玩家1，玩家赢，机器3，做差-2
     玩家2，玩家赢，机器1，做差1
     玩家3，玩家赢，机器2，做差1
     */
    NSLog(@"我是裁判【%@】，现在宣布比赛结果",_name);
    if(playerType - robotType == -2 || playerType - robotType ==1){
        //玩家赢
        //1、显示
        NSLog(@"恭喜玩家【%@】取得了胜利",player->_name);
        //2、加分
        player->_score++;
        
    }else if (playerType == robotType){
        //平局
        NSLog(@"你们真是心有灵犀!");
    }else{
        //机器人胜利
        //1、显示
        NSLog(@"恭喜机器人[%@]取得胜利",robot->_name);
        robot->_score++;
    }
    //得分显示
    NSLog(@"------玩家：【%@】：【%d】---------机器人：【%@】：【%d】",
          player->_name,
          player->_score,
          robot->_name,
          robot->_score
          );
}
@end
