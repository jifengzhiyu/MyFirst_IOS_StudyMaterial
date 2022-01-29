//
//  NSDate+__.m
//  Date
//
//  Created by 翟佳阳 on 2021/8/25.
//

#import "NSDate+__.h"

@implementation NSDate (__)
- (int)year
{
    NSCalendar * calender = [NSCalendar currentCalendar];
    NSDateComponents * com = [calender components:NSCalendarUnitYear fromDate:self];
    return (int)com.year ;
}
@end
