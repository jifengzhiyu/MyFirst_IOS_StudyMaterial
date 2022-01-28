//
//  NSString+jifeng.m
//  非正式协议引入
//
//  Created by 翟佳阳 on 2021/8/16.
//

#import "NSString+jifeng.h"

@implementation NSString (jifeng)
- (int)numberCount
{
    int count = 0;
   
    for(int i = 0; i < self.length; i++)
    {
        unichar ch0 = [self characterAtIndex:i];
        if(ch0 >= '0' && ch0 <= '9')
        {
            count++;
        }
    }
    return count;
}

@end
