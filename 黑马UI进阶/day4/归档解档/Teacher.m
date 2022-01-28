//
//  Teacher.m
//  归档解档
//
//  Created by 翟佳阳 on 2021/10/2.
//

#import "Teacher.h"

@implementation Teacher 

//归档
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeInt:self.age forKey:@"age"];
    [coder encodeObject:self.name forKey:@"name"];
}

//解档
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if(self = [super init]){
        self.age = [coder decodeIntForKey:@"age"];
        self.name = [coder decodeObjectForKey:@"name"];
    }
    return self;
    
}

//必不可少
+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
