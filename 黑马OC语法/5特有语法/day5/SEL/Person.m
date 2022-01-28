//
//  Person.m
//  SEL
//
//  Created by 翟佳阳 on 2021/8/8.
//

#import "Person.h"

@implementation Person
- (void)sayHi{
    NSLog(@"你好呀");
}
- (void)eatfood:(NSString*)food{
    NSLog(@"我吃%@",food);
}
-(void)drinkWithWine:(Wine*)wine{
    
    NSLog(@"我要喝%@,%@,%@,%@酒",wine->_hongJiu,wine->_JinJiu,wine->_LongSheLan,wine->_Weishiji);
}

@end
