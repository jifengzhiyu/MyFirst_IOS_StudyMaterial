//
//  soldier.m
//  士兵突击
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import "soldier.h"

@implementation soldier
-(void)setName:(NSString*)name{
    _name = name;
}
-(NSString*)name{
    return _name;
}

- (void)setType:(NSString*)type{
    _type = type;
}
-(NSString*)type{
    return _type;
}

-(void)setGun:(Gun*)gun{
    _gun = gun;
}
- (Gun*)gun{
    return _gun;
}

- (void)fire{
    NSLog(@"预备，开火。。。。。。");
    [_gun shoot];
}
@end
