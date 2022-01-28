//
//  main.m
//  nil和NULL
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
    if(nil == NULL){
        NSLog(@"妈耶，真是一样的");
    }
    
    Person* p1 = nil;
    [p1 sayHi];
    NSLog(@"妈耶，真的没有报错");
    
    return 0;
}
