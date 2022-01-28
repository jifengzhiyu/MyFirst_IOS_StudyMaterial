//
//  Perosn.m
//  协议的使用
//
//  Created by 翟佳阳 on 2021/8/18.
//

#import "Person.h"
#import "SportProtocol.h"
#import "PlayProtocol.h"

@interface Person()<SportProtocol, PlayProtocol>

@end

@implementation Person
- (void)playLOL {
    NSLog(@"LOL");
}

- (void)paShan {
    NSLog(@"pa");
}

- (void)chifan {
    NSLog(@"chifan");
}

- (void)hetang {
    NSLog(@"hetang");
}

@end
