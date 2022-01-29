//
//  main.m
//  杀人游戏
//
//  Created by 翟佳阳 on 2021/8/6.
//

/*
 1、杀手：
 方法：杀各种各样的人
 2、每一个人被杀的时候都要叫，每个人叫的形式不一样
 每一个人都有叫的方法
 
 男，超级赛亚人，火星人
 */
#import <Foundation/Foundation.h>
#import"Killer.h"
#import "FireMan.h"
#import"SuperMan.h"
#import"Man.h"
int main(int argc, const char * argv[]) {
    Killer* bill = [Killer new];
    Man* m1 = [Man new];
    [bill KillWith:m1];
    
    FireMan* fm = [FireMan new];
    [bill KillWith:fm];
    
    SuperMan* sm = [SuperMan new];
    [bill KillWith:sm];
    
    return 0;
}
