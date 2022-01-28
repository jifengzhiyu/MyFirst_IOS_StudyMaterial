//
//  ViewController.m
//  图片浏览器
//
//  Created by 翟佳阳 on 2021/9/1.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray * pic;
- (IBAction)run;
//索引，来控制当前显示的是第几张图片
//属性初始值0
@property(nonatomic,assign)int index;
@property (weak, nonatomic) IBOutlet UILabel *lblIndex;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UIButton *btnnext;
@property (weak, nonatomic) IBOutlet UIButton *btnPre;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = -1;
    [self next];
    // Do any additional setup after loading the view.
}


//重写pic属性的getter方法
//---------懒加载数据-----用的时候才加载
- (IBAction)run {
}

-(NSArray*)pic{
    //如果没有加载过就加载
    if(_pic == nil)
    {
        //获取pic.list的路径
        //NSBundle mainBundle获取当前文件所在的根目录（最大一个文件夹）
        //在根目录里面搜索目标文件
        NSString * path = [[NSBundle mainBundle] pathForResource:@"pic.plist" ofType:nil];
        //等价于
        //NSString * path = [[NSBundle mainBundle] pathForResource:@"pic" ofType:@“.plist”];
        
        NSArray * array = [NSArray arrayWithContentsOfFile:path];
        //里面储存数据最大的就是NSArray类型的，下面才有字典数组，一个字典数组里面有两个String元素
        //获取文件信息
        _pic = array;
    }
    return _pic;
}

//下一张图片
-(IBAction)next{
    
//    //1、从数组中获取当前这张图片的数据
//    //右值是NSArray
//    NSDictionary * dict = self.pic[self.index];
//    //2、把获取到的数据设置给界面上的控件
//    self.lblIndex.text = [NSString stringWithFormat:@"%d/%lu",self.index+1,self.pic.count];
//    //通过image属性来设置图片框里面的图片
//    self.imgViewIcon.image = [UIImage imageNamed:dict[@"icon"]];
//    //设置这张图片的标题
//    self.lblTitle.text = dict[@"title"];
    //设置下一张按钮是否可以点击
//    self.btnnext.enabled = (self.index != (self.pic.count - 1));
//    //判断是否解锁上一张（两个按钮都封闭就不能转图片了
//    self.btnPre.enabled = (self.index != 0);
    //3、让索引++
    self.index++;

    [self setData];
    
}

- (IBAction)pre {
    //1、让索引++
    self.index--;

    [self setData];

//    //2、从数组中获取当前这张照片的数据
//    NSDictionary * dict = self.pic[self.index];
//    //返回数据给控件
//    self.lblIndex.text = [NSString stringWithFormat:@"%d/%ld",self.index + 1,self.pic.count];
//    //设置图片
//    self.imgViewIcon.image = [UIImage imageNamed:dict[@"icon"]];
//    //设置标题
//    self.lblTitle.text = dict[@"title"];
//    if(self.index == 0){
//        self.btnPre.enabled = NO;
//    }else{
//        self.btnPre.enabled = YES;
//    }
    //判断是否解锁下一张（两个按钮都封闭就不能转图片了
//    self.btnnext.enabled = (self.index != (self.pic.count-1));
}
- (void)setData{
    //1、从数组中获取当前这张图片的数据
    //右值是NSArray
    NSDictionary * dict = self.pic[self.index];
    //2、把获取到的数据设置给界面上的控件
    self.lblIndex.text = [NSString stringWithFormat:@"%d/%lu",self.index+1,self.pic.count];
    //通过image属性来设置图片框里面的图片
    self.imgViewIcon.image = [UIImage imageNamed:dict[@"icon"]];
    //设置这张图片的标题
    self.lblTitle.text = dict[@"title"];
    
    self.btnnext.enabled = (self.index != (self.pic.count - 1));
    //判断是否解锁上一张（两个按钮都封闭就不能转图片了
    self.btnPre.enabled = (self.index != 0);
}
@end
