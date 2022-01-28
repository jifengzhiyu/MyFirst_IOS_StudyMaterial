//
//  Contact.h
//  day3
//
//  Created by 翟佳阳 on 2021/10/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject<NSCoding,NSSecureCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;
@end

NS_ASSUME_NONNULL_END
