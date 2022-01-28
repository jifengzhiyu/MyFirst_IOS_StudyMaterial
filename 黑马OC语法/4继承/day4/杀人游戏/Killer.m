//
//  Killer.m
//  杀人游戏
//
//  Created by 翟佳阳 on 2021/8/6.
//

#import "Killer.h"

@implementation Killer
- (void)KillWith:(Person*)per{
    NSLog(@"哈哈哈，有人要我取你狗命，呼救是没用的");
    [per help];//子类可以继承父类的方法，可以有不同的表现形式
    
}
@end
