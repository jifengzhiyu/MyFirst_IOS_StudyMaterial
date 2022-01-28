//
//  Arry.m
//  案例
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import "Arry.h"

@implementation Arry
- (instancetype)init
{
    if(self = [super init])
{
    for(int i = 1; i < 11; i++)
        {
            _arr[i-1] = i * 10;
    }
}
    return self;
}
//- (void)bianLi
- (void)bianLiWithBlock:(void(^)(int val))processBlock
{//变量名写在后面，所以^就不用写名字了
    for(int i = 0;i < 10; i++)
    {
        processBlock(_arr[i]);
    }
}//让调用者处理遍历出来的数据，block
@end
