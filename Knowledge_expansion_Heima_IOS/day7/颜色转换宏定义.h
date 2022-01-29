
// RGB的颜色设置
#define kUIColorFromWithRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

// RGBA的颜色设置
#define kUIColorFromWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]




// 16进制转换RGB
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 常用背景色
#define kNavBackground [UINavigationBar appearance].backgroundColor = kUIColorFromRGB(0x00AA83)
#define kCellBackground kUIColorFromRGB(0xFFFFFF)
#define kViewBackground kUIColorFromRGB(0xF4F4F4)
#define kLineBackground kUIColorFromRGB(0xBABABA)

// 常用标准颜色
#define kColorBlack kUIColorFromRGB(0x2A2A2A)
#define kColorBlackDeep kUIColorFromRGB(0x000000)
#define kColorBlackLight kUIColorFromRGB(0x686868)
#define kColorGray kUIColorFromRGB(0xC9C9C9)
#define kColorRed  kUIColorFromRGB(0xFF3939)
#define kColorOrange kUIColorFromRGB(0xFF5F00)
#define kColorGreen kUIColorFromRGB(0x00AA83)
#define kColorWhite kUIColorFromRGB(0xFFFFFF)

// 按钮背景颜色
#define kButtonColorWhite kUIColorFromRGB(0xFFFFFF)
#define kButtonColorRed kUIColorFromRGB(0xF3222B)
#define kButtonColorGrey kUIColorFromRGB(0xBEBEBE)
#define kButtonColorBlue kUIColorFromRGB(0x438CEC)
#define kButtonColorGreen kUIColorFromRGB(0x00AA83)
#define kButtonColorOrange kUIColorFromRGB(0xFF5F00)

