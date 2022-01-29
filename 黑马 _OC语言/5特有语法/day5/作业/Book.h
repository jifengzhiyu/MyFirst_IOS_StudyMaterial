//
//  Book.h
//  作业
//
//  Created by 翟佳阳 on 2021/8/7.
//

#import <Foundation/Foundation.h>
#import "Author.h"
NS_ASSUME_NONNULL_BEGIN
/*
 2、书类：
 书名，作者，出版社，出版日期
 */
typedef struct{
    int year;
    int month;
    int day;
}Date;
@interface Book : NSObject
{
    NSString* _name;
    NSString* _publisherName;
    Author* _author;
    //出版日期:年月日（类或者结构体）
    Date _publishDate;
}
- (void)setName:(NSString*)name;
- (NSString*)name;

- (void)setPublisherName:(NSString*)publisherName;
- (NSString*)publisherName;

- (void)setAuthor:(Author*)author;
- (Author*)author;

- (void)setPublishDate:(Date)publishDate;
- (Date)publishDate;
@end

NS_ASSUME_NONNULL_END
