//
//  Book.m
//  作业
//
//  Created by 翟佳阳 on 2021/8/7.
//

#import "Book.h"

@implementation Book
- (void)setName:(NSString*)name{
    _name = name;
}
- (NSString*)name{
    return _name;
}

- (void)setPublisherName:(NSString*)publisherName{
    _publisherName = publisherName;
}
- (NSString*)publisherName{
    return _publisherName;
}

- (void)setAuthor:(Author*)author{
    _author = author;
}
- (Author*)author{
    return _author;
}

- (void)setPublishDate:(Date)publishDate{
    _publishDate = publishDate;
}
- (Date)publishDate{
    return _publishDate;
}
@end
