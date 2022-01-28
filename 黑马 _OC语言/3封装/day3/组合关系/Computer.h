//
//  Computer.h
//  对象之间的关系
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "CPU.h"
NS_ASSUME_NONNULL_BEGIN

@interface Computer : NSObject
{
    CPU* _cpu;
    //Memory* _men;
    //Mainboard* _mb;
}
@end

NS_ASSUME_NONNULL_END
