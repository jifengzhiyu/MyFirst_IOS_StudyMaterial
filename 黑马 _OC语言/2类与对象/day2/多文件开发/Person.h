//
//  Person.h
//  day2
//
//  Created by 翟佳阳 on 2021/8/3.
//

#ifndef Person_h
#define Person_h

@interface Person : NSObject
{
    @public
    NSString* _name;
    int _age;
}
- (void)sayHi;
@end

#endif /* Person_h */
