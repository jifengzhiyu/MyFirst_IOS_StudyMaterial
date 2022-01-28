//
//  main.m
//  使用注意
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    @public
    NSString* _name;
    int _age;
    
}
- (void)sayHi;
@end

@implementation Person
- (void)sayHi{
    NSLog(@"我是插班生");
    NSLog(@"我叫%@,今年%d岁",_name,_age);
}
@end

//------------------------例子---------------------------

@interface Student : NSObject{
    @public
    NSString* _name;
    float _weight;
}
- (void)run;
- (void)eat;
@end

@implementation Student
- (void)run{
    NSLog(@"我在操场绕圈跑，就轻了");
    _weight -= 0.5f;
}

- (void)eat{
    NSLog(@"嘴就是停不下来");
    _weight += 0.9f;
    NSLog(@"体重成了%.2f，后悔也没用",_weight);
}

@end



int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];
    p1->_name = @"Jack";
    p1->_age = 10;
    //同一个类可以创建无数个对象
    [p1 sayHi];
    //该方法是通过哪一个对象来调用的，方法中直接访问的属性就是哪一个对象的
    Person* p2 = [Person new];
    p2->_name = @"xiaoMing";
    p2->_age = 20;
    [p2 sayHi];
    
    //----------------------------------下面是例子----------------
    
    
    Student* s1 = [Student new];
    s1->_name = @"哈皮小丸子";
    s1->_weight = 62.2f;
    [s1 run];
    [s1 eat];
    [s1 run];
    [s1 run];
    [s1 eat];
    return 0;

}



