//
//  main.m
//  士兵突击
//
//  Created by 翟佳阳 on 2021/8/5.
//

/*
 士兵开枪，射出子弹
 
 士兵类：
 属性：姓名，兵种
 行为：开火的方法
 枪类：
 属性：型号，射击
 行为：射击
 枪里面有一个弹夹，弹夹里面有子弹
 子弹类：
 
 */
#import <Foundation/Foundation.h>
#import "soldier.h"

int main(int argc, const char * argv[]) {
    Gun* ak47 = [Gun new];
    [ak47 setModel:@"AK47"];
    
    
    DanJia* dj = [DanJia new];
    [ak47 setDanJia:dj];
    [dj setMaxCapcity:10];
    [dj setBulletCount:5];
    
    soldier *xsd = [soldier new];
    [xsd setName:@"许三多"];
    [xsd setType:@"炮兵"];
    [xsd setGun:ak47];
   
    [xsd fire];
    [xsd fire];
    [xsd fire];
    [xsd fire];
    [xsd fire];
    [xsd fire];
    [xsd fire];
    
    return 0;
}
