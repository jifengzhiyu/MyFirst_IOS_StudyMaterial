//
//  God.m
//  上帝和人的故事
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import "God.h"

@implementation God
- (void)killWithPerson:(Person *)per
{
    NSLog(@"干了这碗孟婆汤");
    per->_leftLife = 0;
    NSLog(@"名字叫做%@的人，挂了",per->_name);
}
- (Person*)makePerson{
    Person* p1 = [Person new];
    p1 ->_name =@"阿巴舔狗";
    p1 ->_age = 21;
    p1->_gender = GenderMale;
    p1->_leftLife = 30;
    return p1;
}

- (Person*)makePersonWithNaame:(NSString*)name andAge:(int)age andGender:(Gender)gender andLeftLife:(int)leftLife{
    Person* p1 = [Person new];
    p1->_name = name;
    p1->_age = age;
    p1->_gender = gender;
    p1->_leftLife = leftLife;
    return p1;
}
@end
