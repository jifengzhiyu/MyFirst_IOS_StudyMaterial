//
//  Student.h
//  作业
//
//  Created by 翟佳阳 on 2021/8/7.
//

#import "Person.h"
#import "Book.h"
NS_ASSUME_NONNULL_BEGIN

@interface Student : Person
{
    NSString* _stuNumber;
    Book* _book;
}

- (void)setStuNumber:(NSString*)stuNumber;
- (NSString*)stuNmber;

- (void)setBook:(Book*)book;
- (Book*)book;
@end

NS_ASSUME_NONNULL_END
