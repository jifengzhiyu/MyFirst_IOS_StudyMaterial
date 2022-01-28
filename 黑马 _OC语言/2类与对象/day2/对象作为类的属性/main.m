//
//  main.m
//  对象作为类的属性
//
//  Created by 翟佳阳 on 2021/8/4.
//

#import <Foundation/Foundation.h>
#import "Person.h"

//人有一条狗,把狗作为人的属性
int main(int argc, const char * argv[]) {
    
    Person* p1 = [Person new];
    Dog* wangCai = [Dog new];
    wangCai->_name = @"旺财";
    wangCai->_color = @"黄色";
    p1->_dog = wangCai;
    p1->_dog->_name = @"大黄";
    [p1->_dog shout];
    QuanQuan* _qq = [QuanQuan new];
    p1->_dog->_qq = _qq;
    /*
     
    QuanQuan* _qq = [QuanQuan new];
    p1->_dog->_qq = _qq;
    这两句可以缩为一句
    p1->_dog->_qq = [QuanQuan new];
    _qq是指针
     
     */
    p1->_dog->_qq->_color = @"土豪金";
    p1->_dog->_qq->_size = 10.0f;
    [p1->_dog->_qq bLingBLing];
    
    
    return 0;
}
