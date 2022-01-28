//
//  ViewController.m
//  day3
//
//  Created by 翟佳阳 on 2021/9/2.
//

#import "ViewController.h"
#import "APP.h"
#import "AppView.h"
@interface ViewController ()
@property(nonatomic,strong)NSArray * apps;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //通过循环创建多个小的UIView
    
    //假设每行的应用个数
    int colmns = 3;
    //每个应用的宽和高
    //获取控制器管理view的宽度
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat appW = 75;
    CGFloat appH = 90;
    //第一行 距离顶部的距离
    CGFloat marginTop = 30;
    CGFloat marginX = (viewWidth - appW * colmns) / (colmns + 1);
    CGFloat marginY = marginX;
    
    
    for(int i = 0; i < self.apps.count;i++)
    {
        
        //获取当前应用的模型
        APP * appModle = self.apps[i];

    //1、创建每个应用的小UIView
        AppView * appView = [AppView appView];
//    UIView * appView = [[UIView alloc]init];
        
//        //通过xib创建每个应用UIVeiw
//        //通过动态加载xib文件创建里面的viewn
//        //1.1)找到xib所在应用的根目录
//        NSBundle * rootBundle = [NSBundle mainBundle];
//        //NSLog(@"%@",[mainBundle bundlePath]);
//        //1.2)在根目录里面找到xib文件并加载
//        AppView * appView = [[rootBundle loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
//        //loadNibNamed。。。方法返回值是NSArray,里面参数不用写xib后缀（本来就是专门针对xib）
//        //lastObject返回值id
        
        
        
        //    //2、设置appView的属性
        //    //2.1设置appView的背景色
        //    appView.backgroundColor = [UIColor blueColor];
        
        //2.2设置appView的Frame属性
        //计算每一个单元格所在的列的索引
        int colIdx = i % colmns;
        //计算每一个单元格所在的行的索引
        int rowIdx = i / colmns;
        CGFloat appX = marginX + colIdx * (appW + marginX);
        CGFloat appY = marginTop + rowIdx * (appH + marginY);
        appView.frame = CGRectMake(appX, appY, appW, appH);
        //3、将appView加到self.view里面
        [self.view addSubview:appView];
        
        //将模型与xib结合起来
        //重写setter方法，解析模型对象的属性，将属性值设置给自定义view的各个子控件
        appView.modle = appModle;
        
        
        
//    //4、向UIView中增加子控件
//    //4.1增加一个图片框
//        UIImageView * imgViewIcon = [[UIImageView alloc] init];
//    //设置背景颜色
//        imgViewIcon.backgroundColor = [UIColor yellowColor];
//    //设置frame
//        CGFloat iconW = 45;
//        CGFloat iconH = 45;
//        CGFloat iconX = (appView.frame.size.width - iconW) * 0.5;
//        CGFloat iconY = 0;
//        imgViewIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
//    //把图片加载到appView
//        [appView addSubview:imgViewIcon];
//
//        //设置图片框里的数据
//        imgViewIcon.image = [UIImage imageNamed:appModle.icon];
        
//        //4.2 增加一个lable标签
//        //创建lable
//        UILabel * lblName = [[UILabel alloc] init];
//        //设置背景颜色
//        lblName.backgroundColor = [UIColor redColor];
//        //设置frame
//        CGFloat nameW = appView.frame.size.width;
//        CGFloat nameH = 20;
//        CGFloat nameY = iconH;
//        CGFloat nameX = 0;
//        lblName.frame = CGRectMake(nameX, nameY, nameW, nameH);
//        //将其添加到appView
//        [appView addSubview:lblName];
//
//        //设置lable数据
//        lblName.text = appModle.name;
//        //设置文字大小
//        lblName.font = [UIFont systemFontOfSize:12];
//        //设置文字居中对齐
//        lblName.textAlignment = NSTextAlignmentCenter;
        
//        //4.3增加一个按钮
//        UIButton * btnDownload = [[UIButton alloc] init];
//        //设置背景颜色
//        btnDownload.backgroundColor = [UIColor greenColor];
//        //设置frame
//        CGFloat btnW = iconW;
//        CGFloat btnH = 20;
//        CGFloat btnX = iconX;
//        CGFloat btnY = CGRectGetMaxY(lblName.frame);
//        //CG_EXTERN CGFloat CGRectGetMaxY(CGRect rect)
//        //@property(nonatomic) CGRect            frame;
//
//        //控件的最大Y值 = Y +控件的高度
//        //控件的最大X值 = X + 控件的宽度
//        btnDownload.frame = CGRectMake(btnX, btnY, btnW, btnH);
//        //添加到appView中
//        [appView addSubview:btnDownload];
//
//        //设置按钮上的文字
//        [btnDownload setTitle:@"下载" forState:UIControlStateNormal];
//        [btnDownload setTitle:@"已安装" forState:UIControlStateDisabled];
//        //设置按钮的文字大小
//        btnDownload.titleLabel.font = [UIFont systemFontOfSize:14];
//
//        //设置按钮的背景图：没有对应图片，就写一下方法
//        //[btnDownload setBackgroundImage:[UIImage imageNamed:@"green"] forState:UIControlStateDisabled];
//
//    //为按钮注册一个单击事件
//        [btnDownload addTarget:self action:@selector(btnDownloadClick) forControlEvents:UIControlEventTouchUpInside];
        
}
}

/// 懒加载,字典转模型
-(NSArray*)apps{
    if(_apps == nil){
        //加载数据
        //1、获取app.plist在手机上的路径
        NSString * path = [[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil];
        //2、根据路径加载数据
        NSArray * arrayDict = [NSArray arrayWithContentsOfFile:path];
        //3、创建一个可变数组来保存模型对象
        NSMutableArray * arrayModels = [NSMutableArray array];
        //4、循环字典数组，将每一个字典对象转化为一个模型对象
        for(NSDictionary *dict in arrayDict){
            //创建一个模型
            APP * modle = [APP appWithDict:dict];
           //一个模型对象由一个字典数组转换
            
            //把模型添加到可变数组中去
            [arrayModels addObject:modle];
        }
        _apps = arrayModels; 
    }
    return _apps;
    //MutableArray赋值给NSArray
}
    
@end
