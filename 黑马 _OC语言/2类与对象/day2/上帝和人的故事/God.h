//
//  God.h
//  上帝和人的故事
//
//  Created by 翟佳阳 on 2021/8/3.
//

#import <Foundation/Foundation.h>
#import "Gender.h"
#import "Person.h"
NS_ASSUME_NONNULL_BEGIN

@interface God : NSObject
{
    @public
    NSString* _name;
    int _age;
    Gender _gender;
}
- (void)killWithPerson: (Person*)per;

- (Person*)makePerson;
- (Person*)makePersonWithNaame:(NSString*)name andAge:(int)age andGender:(Gender)gender andLeftLife:(int)leftLife;
@end

NS_ASSUME_NONNULL_END
