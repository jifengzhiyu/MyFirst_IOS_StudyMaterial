//
//  Student.h
//  属性的封装
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
{
    
    NSString* _name;
    int _age;
    int _yuWen;
    int _shuXue;
    int _yingYu;
}
- (void)setName:(NSString*)name;
- (NSString*)name;
- (void)setAge:(int)age;
- (int)age;
- (void)setYuWen:(int)yuWen;
- (void)setShuXue:(int)shuXue;
- (void)setYingYu:(int)yingYu;

- (int)yuWen;
- (int)shuXue;
- (int)yingYu;
- (void)show;


@end

NS_ASSUME_NONNULL_END
