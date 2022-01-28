//
//  main.m
//  上帝和人的故事
//
//  Created by 翟佳阳 on 2021/8/3.
//

/*
 上帝类：
 属性：姓名 年龄 性别
 行为：杀人
 
 人类：
 属性：姓名 年龄 性别 剩余寿命
 行为：展示
 */

#import <Foundation/Foundation.h>
#import "God.h"
int main(int argc, const char * argv[]) {
    God* g1 = [God new];
    g1->_name = @"阿巴阿巴";
    g1->_age = 444444444;
    g1->_gender =  GemderFeMale;
    
    Person* p1 = [Person new];
    p1->_name = @"小明";
    p1->_age = 21;
    p1->_leftLife = 80;
    p1->_gender = GenderMale;
    
    [g1 killWithPerson:p1];
    NSLog(@"p1->leftLife = %d",p1->_leftLife);
    
    
    Person* p2 = [g1 makePerson];
    [p2 show];
    
    Person* p3 = [g1 makePersonWithNaame:@"李华" andAge:0 andGender:GenderMale andLeftLife:90];
    [p3 show];
    return 0;
}
