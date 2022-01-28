//
//  Student.m
//  属性的封装
//
//  Created by 翟佳阳 on 2021/8/5.
//

#import "Student.h"

@implementation Student
- (void)setName:(NSString*)name{
    if([name length] < 2 || [name isEqualToString:@"毛泽东"] || [name isEqualToString:@"胡锦涛"] || [name isEqualToString:@"习近平"]){
        _name = @"无名";
        return;
    }
    _name = name;
}
- (NSString*)name{
    return _name;
}
- (void)setAge:(int)age{
    if(age >= 0 && age <=120){
        _age = age;
    }else{
        _age = 18;
    }
}
- (int)age{
    return _age;
}
- (void)setYuWen:(int)yuWen{
    if(yuWen >= 0 && yuWen <= 150){
        _yuWen = yuWen;
    }else{_yuWen = 0;
}
}
- (void)setShuXue:(int)shuXue{
    if(shuXue >= 0 && shuXue <= 150){
        _shuXue = shuXue;
    }else{_shuXue = 0;
}
}
- (void)setYingYu:(int)yingYu{
    if(yingYu >= 0 && yingYu <= 150){
        _yingYu = yingYu;
    }else{_yingYu = 0;
}
}
- (int)yuWen{
    return _yuWen;
}
- (int)shuXue{
    return _shuXue;
}
- (int)yingYu{
    return _yingYu;
}
- (void)show{
    int zongFen = _yuWen + _shuXue + _yingYu;
    double pingJun = (_yuWen + _shuXue + _yingYu)/3;
    NSLog(@"我的名字是%@，今年%d岁，总分是%d,平均分是%lf",_name,_age,zongFen,pingJun);
}
@end
