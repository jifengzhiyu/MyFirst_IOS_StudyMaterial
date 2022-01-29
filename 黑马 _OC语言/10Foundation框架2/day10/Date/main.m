//
//  main.m
//  Date
//
//  Created by 翟佳阳 on 2021/8/24.
//

#import <Foundation/Foundation.h>
#import "NSDate+__.h"
int main(int argc, const char * argv[]) {
    
    NSDate * date = [NSDate date];
    //1、创建一个日历对象，可以从日历对象中取得日期的各个部分
    NSCalendar * calender = [NSCalendar currentCalendar];

    //2、让日历对象从日期对象取出各个部分
    NSDateComponents * com = [calender components:NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitHour fromDate:date];
    //- (NSDateComponents *)components:(NSCalendarUnit)unitFlags fromDate:(NSDate *)date;
    //components [kəmˈpəʊnənts] 组成部分
    //单个 ｜ 按位运算或 只要对应的二个二进位有一个为1时，结果位就为1

    NSLog(@"%lu---%lu-----%lu",com.year,com.day,com.hour);
    //@property NSInteger year;
    //typedef long NSInteger;

    
    NSLog(@"year = %d",date.year);
    
//    NSString * str = @"12";
//    NSDate * startDate = [NSDate date];
//    for(int i = 0; i < 30000; i++)
//    {
//        str = [NSString stringWithFormat:@"%@%d",str,i];
//    }
//    NSDate * endDate = [NSDate date];
//    double  sj = [endDate timeIntervalSinceDate:startDate];
//    //- (NSTimeInterval)timeIntervalSinceDate:(NSDate *)anotherDate;
//    //typedef double NSTimeInterval;
//
//    NSLog(@"%lf",sj);
    
    
//    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:-5000];
//    //interval    [ˈɪntəvl]。间隔，间隙
//
//    //+ (instancetype)dateWithTimeIntervalSinceNow:(NSTimeInterval)secs;
//    //typedef double NSTimeInterval;
//    //往后多少秒
//    NSLog(@"%@",date);
    
//    NSString * strDate = @"2021年12月12号 12点12分12秒";
//    //1、创建一个日期格式化对象
//    NSDateFormatter * formatter = [NSDateFormatter new];
//    //2、指定日期字符串格式
//    formatter.dateFormat = @"yyyy年MM月dd号 HH点mm分ss秒";
//    //3、转换
//    NSDate * date = [formatter dateFromString:strDate];
//    //- (nullable NSDate *)dateFromString:(NSString *)string;
//    NSLog(@"%@",date);
    
//    NSDate * date = [NSDate new];
//    //1、创建一个日期格式化对象，用该对象来将一个日期输出为指定的格式
//    NSDateFormatter * formatter = [NSDateFormatter new];
//    //2、指定该 日期格式化对象 转换的格式
//    //yyyy 年
//    //MM 月
//    //dd 天
//    //HH 时24
//    //hh 时12
//    //mm 分钟
//    //ss 秒
//    formatter.dateFormat = @"yyyy年MM月dd日 hh时mm分ss秒";
//    //@property (null_resettable, copy) NSString *dateFormat;
//    NSString * str = [formatter stringFromDate:date];
//    //- (NSString *)stringFromDate:(NSDate *)date;
//    //Returns a string representation of a specified date that the system formats using the receiver’s current settings.
//    NSLog(@"%@",str);
    
//    NSLog(@"%@",date);
    
    return 0;
}
