//
//  soldier.h
//  士兵突击
//
//  Created by 翟佳阳 on 2021/8/5.
//

/*
 士兵类：
 属性：姓名，兵种
 行为：开火的方法
 */
#import <Foundation/Foundation.h>
#import "Gun.h"
NS_ASSUME_NONNULL_BEGIN

@interface soldier : NSObject
{
    NSString* _name;
    NSString* _type;
    Gun* _gun;
}

-(void)setName:(NSString*)name;
-(NSString*)name;

- (void)setType:(NSString*)type;
-(NSString*)type;

-(void)setGun:(Gun*)gun;
- (Gun*)gun;

- (void)fire;
@end


NS_ASSUME_NONNULL_END
