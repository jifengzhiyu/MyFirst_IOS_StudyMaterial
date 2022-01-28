![image-20210831225842357](transform%E5%B1%9E%E6%80%A7%E4%BB%8B%E7%BB%8D.assets/image-20210831225842357.png)

```objective-c
struct CGAffineTransform {
  CGFloat a, b, c, d;
  CGFloat tx, ty;
};
```

Translation 转变

# 平移

- 一开始的数据是0

向上平移就是负数：距离原来位置的值

- 一次性平移:

```objective-c
//一次性平移，直接修改结构体的值
    self.btnIcon.transform = CGAffineTransformMakeTranslation(0, -50);
```

- 多次平移：

如果想要多次平移，需要基于每一次平移前旧的值进行平移

```objective-c
    self.btnIcon.transform = CGAffineTransformTranslate(self.btnIcon.transform, 0, 50);
   //第一个参数是每一次平移的基准点：即每一次平移前旧的值
//有点像 += -=

CG_EXTERN CGAffineTransform CGAffineTransformTranslate(CGAffineTransform t,
  CGFloat tx, CGFloat ty) CG_AVAILABLE_STARTING(10.0, 2.0);
```

# 缩放

```objective-c
//一次性
    self.btnIcon.transform = CGAffineTransformMakeScale(1.5, 1.5);
```



```objective-c
 //多次缩放
    self.btnIcon.transform = CGAffineTransformScale(self.btnIcon.transform, 1.5, 1.5);

CG_EXTERN CGAffineTransform CGAffineTransformScale(CGAffineTransform t,
  CGFloat sx, CGFloat sy) CG_AVAILABLE_STARTING(10.0, 2.0);
```

# 旋转

![image-20210901082552884](transform%E5%B1%9E%E6%80%A7%E4%BB%8B%E7%BB%8D.assets/image-20210901082552884.png)

```objective-c
    //一次性,顺时针旋转45度，如果逆时针写负数弧度
    self.btnIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
```



```objective-c
//旋转多次，顺时针旋转45度，如果逆时针写负数弧度
    self.btnIcon.transform = CGAffineTransformRotate(self.btnIcon.transform, M_PI_4);


CG_EXTERN CGAffineTransform CGAffineTransformRotate(CGAffineTransform t,
  CGFloat angle) CG_AVAILABLE_STARTING(10.0, 2.0);
```

![image-20210901083638495](transform%E5%B1%9E%E6%80%A7%E4%BB%8B%E7%BB%8D.assets/image-20210901083638495.png)

# 回归

- 让控件回到最开始的位置

```objective-c
self.btnIcon.transform = CGAffineTransformIdentity;

CG_EXTERN const CGAffineTransform CGAffineTransformIdentity
```

# 

