//
//  Contact.m
//  day3
//
//  Created by 翟佳阳 on 2021/10/1.
//

#import "Contact.h"

@implementation Contact
//归档
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_number forKey:@"number"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if(self = [super init]){
        _name = [coder decodeObjectForKey:@"name"];
        _number = [coder decodeObjectForKey:@"number"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
