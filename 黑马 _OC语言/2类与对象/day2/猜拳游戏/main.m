//
//  main.m
//  猜拳游戏
//
//  Created by 翟佳阳 on 2021/8/4.
//
/*
 1、流程
 1）玩家出拳
 2）机器人出拳
 3）裁判宣布比赛结果
 
 2、类
 玩家类：
 属性：姓名，出的拳头，得分
 方法：出拳行为，用户选择
 
 机器人类：
 属性：姓名，拳头，得分
 方法：出拳，随机
 
 裁判类：
 属性：姓名
 方法：判断输赢，分数
 
 */

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Robot.h"
#import "Judge.h"
int main(int argc, const char * argv[]) {
    
    Player* _xiaoMing = [Player new];
    _xiaoMing->_name = @"小明";
    
    Robot* _aGou = [Robot new];
    _aGou->_name = @"阿法狗";
    
    Judge* _heishao = [Judge new];
    _heishao->_name = @"黑哨";
    
    
    while (1) {
    
    [_xiaoMing showFist];
    [_aGou showFist];
    [_heishao caiJueWithPlayer:_xiaoMing andRobot:_aGou];
        NSLog(@"你还要玩一把吗？ y/n");
        char ans = 'a';
        rewind(stdin);
        scanf("%c",&ans);
        if(ans == 'n' || ans == 'N'){
            NSLog(@"有空继续来呀");
            break;
        }
    }
    return 0;
}
