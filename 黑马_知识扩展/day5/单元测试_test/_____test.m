//___FILEHEADER___
#import "JFTools.h"
#import <XCTest/XCTest.h>

@interface ___FILEBASENAMEASIDENTIFIER___ : XCTestCase

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

- (void)testExample {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //要测试时, 点击左边的菱形按钮即可
    //运行正常, 会出现绿色
    //运行不正常, 会出现红色
    //最顶部还有一个菱形按钮, 用于多个测试代码都需要执行是, 可以点击顶部的按钮来统一测试
    
    //XCTAssert : 断言
    XCTAssert([JFTools sumNum1:250 num2:38] == 288, @"方法错误");
    
//    if ([HMTools sumNum1:250 num2:38] == 288) {
//        NSLog(@"逻辑代码写的是正确的");
//    }
    
}

- (void)testExample1 {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //要测试时, 点击左边的菱形按钮即可
    //运行正常, 会出现绿色
    //运行不正常, 会出现红色
    //最顶部还有一个菱形按钮, 用于多个测试代码都需要执行是, 可以点击顶部的按钮来统一测试
    
    //XCTAssert : 断言
    XCTAssert([JFTools sumNum1:250 num2:38] == 288, @"方法错误1");
    
//    if ([HMTools sumNum1:250 num2:38] == 288) {
//        NSLog(@"逻辑代码写的是正确的");
//    }
    
}





@end
