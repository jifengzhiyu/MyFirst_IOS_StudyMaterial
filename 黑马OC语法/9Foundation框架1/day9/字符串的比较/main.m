//
//  main.m
//  字符串的比较
//
//  Created by 翟佳阳 on 2021/8/20.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    
    NSString * path = @"asdadada.h";
    BOOL res = [path hasSuffix:@".h"];
    NSLog(@"%d",res);
    
    
//    NSString * str = @"http://www.hawai.com";
//    BOOL res = [str hasPrefix:@"http//"];
//    NSLog(@"%d",res);
    
    
//    NSString * str1 = @"a22";
//    NSString * str2 = @"b22";
//    int res = [str1 compare:str2 options:NSNumericSearch];
//    //int res = [str1 compare:str2 options:NSCaseInsensitiveSearch];
//        switch (res) {
//                case -1:
//                    //str1比str2小
//                    NSLog(@"小");
//                    break;
//                case 0:
//                    NSLog(@"相等");
//                    break;
//                case 1:
//                    //str1比str2大
//                    NSLog(@"大");
//                    break;
//                     default:
//                    break;
//            }
    
    
//    NSString * str1 = @"ROSE";
//    NSString * str2 = @"rose";
//
//    int res = [str1 compare:str2 options:NSCaseInsensitiveSearch];
//    switch (res) {
//            case -1:
//                //str1比str2小
//                NSLog(@"小");
//                break;
//            case 0:
//                NSLog(@"相等");
//                break;
//            case 1:
//                //str1比str2大
//                NSLog(@"大");
//                break;
//                 default:
//                break;
//        }
    
    
//    NSComparisonResult res = [str1 compare:str2];
//    switch (res) {
//        case NSOrderedAscending:
//            //str1比str2小
//            NSLog(@"小");
//            break;
//        case NSOrderedSame:
//            NSLog(@"相等");
//            break;
//        case NSOrderedDescending:
//            //str1比str2大
//            NSLog(@"大");
//            break;
//             default:
//            break;
//    }
    return 0;
}
