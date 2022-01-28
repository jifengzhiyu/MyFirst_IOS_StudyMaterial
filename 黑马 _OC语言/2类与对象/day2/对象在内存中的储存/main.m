//
//  main.m
//  对象在内存中的储存
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    @public
    NSString* _name;
    int _age;
}

- (void)sayHi;
@end

@implementation Person
- (void)sayHi{
    NSLog(@"大家好，我叫%@，今年%d岁",_name,_age);
}
@end
int main(int argc, const char * argv[]) {
    Person* p1 = [Person new];//类加载
    Person* p2 = [Person new];//不会类加载
    return 0;
}
