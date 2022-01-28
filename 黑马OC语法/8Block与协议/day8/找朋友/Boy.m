//
//  Boy.m
//  找朋友
//
//  Created by 翟佳阳 on 2021/8/19.
//

#import "Boy.h"

@implementation Boy
- (void)love
{
    NSLog(@"爱你");
    [_grilFriend wash];
    [_grilFriend cook];

}
- (void)cook {
    NSLog(@"狗粮");
}

- (void)wash {
    NSLog(@"狗屎");
}

@end
