//
//  ViewController.m
//  图文混排OC
//
//  Created by 翟佳阳 on 2021/12/11.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 目标：生成带表情图片的内容 "我[爱你]!!!"
    // Attachment - 附件
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    
    attachment.image = [UIImage imageNamed:@"d_aini"];
    
    NSAttributedString *attrStr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithString:@"我"];
    [strM appendAttributedString:attrStr];
    
    self.label.attributedText = strM;
}


@end

