##Quartz2D 简介及用途
- Quartz 2D 是一个二维绘图引擎，同时支持iOS和Mac系统，Quartz2D的API是纯C语言的来自于Core Graphics框架

- Quartz 2D 能完成的工作：
1 绘制图层：线条，三角形，矩形，圆，弧，扇形等
2 绘制文字
3 绘制图片
4 读取生成PDF
5 截图，裁剪图片
6 自定义UI控件

- Quartz 2D实力
 1 裁剪图片
 2 涂鸦、画板
 3 手势解锁
 4 折线图、饼状图、柱状图

- 通常在我们面对比较复杂，个性化的UI需求时，通常利用Quartz 2D通过自定义View的方法绘制出我们需要的UI

##图形上下文
- 如何利用Quartz 2D技术自定义绘制View
 1 首先，得有图形上下文，因为它能保存绘图信息，并且决定着绘制到什么地方去
 2 其次，那个图形上下文必须跟view相关联，才能将内容绘制到view上面

- 自定义View的步骤
 1 新建一个类，继承自UIView
 2 实现- (void)drawRect:(CGRect)rect方法，然后在这个方法中
    - 取得跟当前view相关联的图形上下文
    - 绘制相应的图形内容
    - 利用图形上下文将绘制的所有内容渲染显示到view上面

##drawRect:方法
- 只有在在drawRect:方法中才能取得跟view相关联的图形上下文
- 当view第一次显示到屏幕上时（被加到UIWindow上显示出来）调用
- 手动调用view的setNeedsDisplay或者setNeedsDisplayInRect:时
- 注意手动 [self drawRect] 是无效的写法

##绘图方法介绍

- 画图步骤
 1 获取上下文
 2 创建路径（描述路径）
 3 把路径添加到上下文
 4 渲染上下文
- 画直线（方法一）
 
```
-(void)drawRect:(CGRect)rect{
    //1.获取图形上下文
    //目前我们所用的上下文都是以UIGraphics
    //CGContextRef Ref :引用 CG 目前使用到的类型和函数一般都是CG开头
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.描述路径
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //设置起点
    //path 给那个路径设置起点
    
    CGPathMoveToPoint(path, NULL, 50, 50);
    
    //添加一根线到某个点
    CGPathAddLineToPoint(path, NULL, 200, 200);
    
    //3.把路径添加到上下文
    
    CGContextAddPath(ctx, path);
    
    //4.渲染上下文
    
    CGContextStrokePath(ctx);

}
```

- 画直线（方法二）

```
-(void)drawRect:(CGRect)rect{
    //获取上下文 自动创建路径
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //描述路径
    //设置起点
    CGContextMoveToPoint(ctx, 50, 50);
    
    CGContextAddLineToPoint(ctx, 200, 200);
    //渲染上下文
    CGContextStrokePath(ctx);

}
```

-  画直线（方法三）

```
-(void)drawRect:(CGRect)rect{

    //UIKIT 封装的绘图功能
    //贝斯曲线
    //创建路径
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    //设置起点
    [path moveToPoint:CGPointMake(50, 50)];
    //添加一个线到某个点
    [path addLineToPoint:CGPointMake(100, 100)];
    //绘制路径
    
    [path stroke];
}
```

- 设直线的状态

```
原生设置线的状态
-(void)drawRect:(CGRect)rect{
    //画两根线
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //描述路径
    //设置起点
    CGContextMoveToPoint(ctx, 50, 100);
    
    CGContextAddLineToPoint(ctx, 100, 100);
    //默认下一个线的起点就是上一根线的重点 不用重新设置
    CGContextAddLineToPoint(ctx, 100, 150);
    
    //设置绘图状态 在渲染之前
    //color
    [[UIColor greenColor] setStroke];
    
    //线宽
    CGContextSetLineWidth(ctx, 10);
    //链接样式
    /**
     *kCGLineJoinMiter,切角
     *kCGLineJoinRound,圆角
     *kCGLineJoinBevel
     */
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //    kCGLineCapButt,
    //    kCGLineCapRound,
    //    kCGLineCapSquare
    //设置顶角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //渲染上下文
    CGContextStrokePath(ctx);

}

```

- 贝斯曲线（贝瑟尔曲线）

```
//贝斯 画线 设置线的状态
-(void)drawRect:(CGRect)rect{
    //贝斯曲线设置图形上下文状态
    //为了方便管理状态 最好一个线对应一个路径
    UIBezierPath * path = [UIBezierPath bezierPath];
    //设置起点
    [path moveToPoint:CGPointMake(50, 100)];
    //设置终点
    [path addLineToPoint:CGPointMake(100, 100)];
    //线宽
    path.lineWidth = 10;
    //绘制
    [path stroke];
    
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    
    [path1 moveToPoint:CGPointMake(100, 100)];
    
    [path1 addLineToPoint:CGPointMake(100, 150)];
    
    path1.lineWidth = 5;
    
    [path1 stroke];

}
```

- 画曲线

```
-(void)drawRect:(CGRect)rect{
    //绘制曲线
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //描述路径
    //设置起点
    CGContextMoveToPoint(ctx, 50, 100);
    
    //cpx cpy 控制点的横纵坐标和终点坐标
    CGContextAddQuadCurveToPoint(ctx, 75, 50, 100, 100);
    
    CGContextStrokePath(ctx);

}
```

- 画图形

  - 圆角矩形
```
//圆角矩形
       UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 100, 100) cornerRadius:50];
    
        //[path stroke];
        //填充（必须是一个封闭路径）
        [path fill];
```
 - 椭圆
```
      //椭圆
          UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 50, 100)];
        //填充（必须是一个封闭路径）
         [path fill];
```
 - 画一个圆弧
```
//画一个圆弧
       //    Center 圆心
//    startAngle 起点
//    半径radius
//    endAngle 弧度
//    clockwise 顺时针 逆时针
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI clockwise:YES];
        [path stroke];
```
 - 画扇形
```
//画扇形
       UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:CGPointMake(100, 100)];
    //关闭路径
//        [path closePath];
    //渲染
    //    [path stroke];
    //默认关闭路径
    [path fill];
```

- 画饼状图

```
//画饼状图
- (void)drawRect:(CGRect)rect {

    NSArray * arr = @[@(25),@(25),@(50)];
    
    NSArray * colorArr = @[
                           [UIColor redColor],
                           [UIColor purpleColor],
                           [UIColor greenColor]
                           ];

    CGFloat radius = rect.size.width*0.5;
    
    CGPoint center = CGPointMake(radius, radius);
    
    CGFloat startAngle = 0;
    CGFloat angle = 0;
    CGFloat endAngle = 0;

    for (int i = 0; i <arr.count; i++) {
  
        startAngle = endAngle;
        
        angle = [arr[i] doubleValue]/100.0 * M_PI * 2;
        
        endAngle = startAngle + angle;
          
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        [path addLineToPoint:center];
        
        UIColor * color = colorArr[i];
        
        [color set];
        
        [path fill];

    }

}
```

- 画柱状图

```
- (void)drawRect:(CGRect)rect {

    NSArray * arr = @[@(25),@(25),@(50)];
    NSArray * colorArr = @[
                           [UIColor redColor],
                           [UIColor purpleColor],
                           [UIColor greenColor]
                           ];

    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 0;
    CGFloat h = 0;
    for (int i = 0 ; i<arr.count; i++) {
        
        w = rect.size.width/ (2* arr.count-1);
        x = 2 * w * i;
        h = [arr[i] doubleValue]/100.0 *rect.size.height;
        y = rect.size.height - h;
        
        UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        UIColor * color = colorArr[i];
        
        [color set];
        
        [path fill];

    }
      
}

```

- 绘制文字

```
//绘制文字
-(void)drawRect:(CGRect)rect{

    NSString * text = @"嘿嘿嘿嘿嘿嘿嘿";
    
    NSMutableDictionary * textDict = [NSMutableDictionary dictionary];
    //设置字体颜色
    textDict[NSForegroundColorAttributeName] = [UIColor redColor];
    //设置字体大小
    textDict[NSFontAttributeName]  = [UIFont systemFontOfSize:30];
    //设置字体空心颜色和宽度
    textDict[NSStrokeWidthAttributeName] = @(3);
    
    textDict[NSStrokeColorAttributeName] = [UIColor yellowColor];
    
    //创建shadow
    NSShadow * shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor greenColor];
    shadow.shadowOffset = CGSizeMake(4, 4);
    textDict[NSShadowAttributeName] = shadow;
    //绘制文字 不会换行
    //[text drawAtPoint:CGPointZero withAttributes:textDict];
    //可以换行
    [text drawInRect:self.bounds withAttributes:textDict];

}

```

- 绘制图片

```
- (void)drawRect:(CGRect)rect {
  
    // 超出裁剪区域的内容全部裁剪掉
    // 注意：裁剪必须放在绘制之前
    UIRectClip(CGRectMake(0, 0, 50, 50));
    
    UIImage *image = [UIImage imageNamed:@"001"];
    //绘图
    // 默认绘制的内容尺寸跟图片尺寸一样大
    //    [image drawAtPoint:CGPointZero];
    //图片在rect内展示
    //    [image drawInRect:rect];
    // 图片平铺
    [image drawAsPatternInRect:rect];
    
}
```

- 矩阵操作

```
-(void)drawRect:(CGRect)rect{

    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置路径
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, rect.size.width, rect.size.height/2)];
    
    [[UIColor redColor] set];
    
    //上下文的矩阵操作
    //矩阵操作必须在添加路径之前
    //向下平移
    CGContextTranslateCTM(ctx, 50, 50);
    //缩放
    CGContextScaleCTM(ctx, 0.5, 0.5);
    //旋转
    CGContextRotateCTM(ctx, M_PI_4);

    //把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //渲染上下文
    CGContextFillPath(ctx);

}

```
##位图上下文
- 图片水印
  - 有时候防止自己的图片被盗图，经常在图片右下角加上自己的水印
![水印.jpeg](http://upload-images.jianshu.io/upload_images/1161239-fdfcbf8a90438a0f.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
//创建一个imageview
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 558)];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];

    UIImage * image = [UIImage imageNamed:@"小黄人"];
    //图片加水印
    //绘制图片到新的图片上 需要用到位图上下文
    //位图上下文回去方式跟layer上下文不一样，位图上下文需要我们手动创建
    //开启一个位图上下文，注意位图上下文跟view无关，所以不需要在drawRect方法中实现
    //size：位图上下文的尺寸（新图片的尺寸）
    //opaque:不透明度 YES不透明，NO透明，通常都是透明的上下文
    //scale通常不需要缩放上下文，取值为0 表示不缩放
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //1绘制原生图片
    [image drawAtPoint:CGPointZero];
    //2给原生图片添加文字水印
    NSString * str = @"黑黑";
    //创建字典属性
    NSMutableDictionary * textDic = [NSMutableDictionary dictionary];
    textDic[NSForegroundColorAttributeName] = [UIColor purpleColor];
    textDic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [str drawAtPoint:CGPointMake(200, 528) withAttributes:textDic];
    //3生成一张图片 （从上下文中获取）
    UIImage * imageWater = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    imageView.image = imageWater;
```
- 图片裁剪
  - APP中常见的圆形头像，以及，头像上的一层圆形的圈圈
![图片裁剪.jpeg](http://upload-images.jianshu.io/upload_images/1161239-d0bae690985d292a.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
//创建一个imageview
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    //加载图片
    UIImage * image = [UIImage imageNamed:@"阿狸头像"];
    //图片宽高
    CGFloat imageWH = image.size.width;
    //设置圆环的宽度
    CGFloat border = 1;
    //圆形的宽高
    CGFloat ovalWH = imageWH + 2 * border;
    //1开启个上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    //2画大圆
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    [[UIColor redColor] set];
    [path fill];
    //3设置裁剪区域(小圆)
    UIBezierPath * clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    //进行裁剪
    [clipPath addClip];
    //4绘制图片
    [image drawAtPoint:CGPointMake(border, border)];
    //5获取图片
    UIImage * clipImage = UIGraphicsGetImageFromCurrentImageContext();
    //6关闭上下文
    UIGraphicsEndImageContext();
    imageView.image = clipImage;
```
- 屏幕截屏功能
  - 截取的是一个View的layer层 并不是一个图片，要与图片截取区分
```
//开启一个位图上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    //拿到上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把控件上的图层渲染到上下文
    [self.view.layer renderInContext:ctx];
    //不能用下面这个方法 layer 只能渲染
    //    [self.view.layer drawInContext:ctx];
    //生成一张图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
```
- 图片截取
   - 滑动手指出现矩形截图框
   - ![截图时.jpeg](http://upload-images.jianshu.io/upload_images/1161239-ab3bf6860166bad8.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
   - 松开手指截图成功
   - ![截图后.jpeg](http://upload-images.jianshu.io/upload_images/1161239-136e8e03c2c06d61.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

   - 截取的是imageView的layer层与上面的方法区分
   - 在imageView上添加pan手势
   - 触发方法
```
-(void)pan:(UIPanGestureRecognizer *)pan{
CGPoint endP = CGPointZero;
    if(pan.state == UIGestureRecognizerStateBegan){
        
        //获取手指最开始的触摸点
        CGPoint startP = [pan locationInView:self.view];
        self.startP = startP;
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
        endP = [pan locationInView:self.view];
        
        CGFloat w = endP.x -self.startP.x;
        CGFloat h = endP.y - self.startP.y;
        //获取截图
        CGRect clipRect = CGRectMake(self.startP.x, self.startP.y, w, h);
        //创建view 黑色半透明
        self.clipView.frame = clipRect;
        
    }else if (pan.state == UIGestureRecognizerStateEnded){
        
        //开启一个原图一样大的位图上下文
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
        //设置裁剪区域
        UIBezierPath * clipPath = [UIBezierPath bezierPathWithRect:self.clipView.frame];
        //进行裁剪
        [clipPath addClip];
        //获取上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        //绘制图片
        [self.imageView.layer renderInContext:ctx];
        //从上下文获取裁剪区域
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        self.imageView.image = image;
        //        self.imageView.backgroundColor = [UIColor redColor];
        
        UIGraphicsEndImageContext();
        //截取的view设置为nil
        [_clipView removeFromSuperview];
        _clipView = nil; 
    }
}
```
- 图片擦除
  - 两张类似图片重叠防止，一张完整的图片在上，另一张被擦除一部分的图片在下，通过位图上下文擦除上面的图片漏出下面的完整的图片造成假象。
 - 擦除前（害羞的美女）
 - ![擦除前.jpeg](http://upload-images.jianshu.io/upload_images/1161239-afe35174d78cbb56.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 - 擦除后（想不想继续扒光她）
 - ![擦除后.jpeg](http://upload-images.jianshu.io/upload_images/1161239-67b29ec107c6bc80.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 - 在上面的图片添加一个pan手势，实现pan的触发方法
```
-(void)pan:(UIPanGestureRecognizer *)pan{
CGPoint curP = [pan locationInView:self.view];
    CGFloat wh = 50;
    CGFloat x = curP.x - 0.5 * wh;
    CGFloat y = curP.y - 0.5 * wh; 
    CGRect rect = CGRectMake(x, y, wh, wh);
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //把上面那张控件的layer渲染上去
    [self.imageA.layer renderInContext:ctx];
    //擦除图片
    CGContextClearRect(ctx, rect);
    //上下文中拿到图片一张图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();    
    self.imageA.image = image;
    //关闭上下文
    UIGraphicsEndImageContext();
}
```
- 手势解锁
  - 示例
  - ![手势解锁.jpeg](http://upload-images.jianshu.io/upload_images/1161239-925b22863cadbe77.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  - 自定义一个九宫格布局按钮的view，分别这是button的normal和selected背景图片
  - view添加一个pan手势
  - pan触发的方法中实现
```
-(void)pan:(UIPanGestureRecognizer *)pan{
//时刻记录手指当前的位置
    self.fingerPoint = [pan locationInView:self];
    for (UIButton * btn in self.subviews) {
        //如果手指的位置在btn的范围内 且这个按钮没有被选中过
        if (CGRectContainsPoint(btn.frame, self.fingerPoint) && (!btn.selected)) {
            //改变按钮状态为选中
            btn.selected = YES;
            //加入选中数组中
            [self.selectsBtn addObject:btn];
        }    
    }
    //滑动结束后重置状态
    if (pan.state == UIGestureRecognizerStateEnded) {    
        // 创建可变字符串
        NSMutableString *strM = [NSMutableString string];
        // 保存输入密码
        for (UIButton *btn in self.selectsBtn) {     
            [strM appendFormat:@"%ld",btn.tag];
        }
        //记录密码
        NSLog(@"%@",strM);
        // 还原界面
        // 取消所有按钮的选中
//        [self.selectsBtn makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
        //讲所有选中的按钮状态改变
        [self.selectsBtn enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton * btn = obj;
            btn.selected=NO;
        }];
        // 清除画线,把选中按钮清空
        [self.selectsBtn removeAllObjects];
  
    }
    [self setNeedsDisplay];
}
```
- 画板
  - 一个简单的画板示例
  - 
![画板.jpeg](http://upload-images.jianshu.io/upload_images/1161239-eae28993eebce02c.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  - 每个pan事件触发begin时创建一个路径，加载到数组中保存
```
-(void)pan:(UIPanGestureRecognizer *)pan{
//获得手指的位置
    CGPoint fingerPoint = [pan locationInView:self];
    //pan 开始时
    if (pan.state == UIGestureRecognizerStateBegan) {
    
        //继承UIBezierPath，增加一个保存颜色的属性
        MyBezierPath * path = [MyBezierPath bezierPath];
        //设置线宽
        path.lineWidth = self.lineWidth;
        //设置颜色
        path.pathColor = self.pathColor;
         //设置起点
        [path moveToPoint:fingerPoint];
        self.path = path;
        //讲路径加入到数组中保存
        [self.paths addObject:path];
    }
    //滑动时 通过手指位置改变进行连线
    [self.path addLineToPoint:fingerPoint];
    //重新绘制
    [self setNeedsDisplay];
}
```
  - 实现drawRect方法，遍历数组中保存的每条路径，进行绘图
```
-(void)drawRect:(CGRect)rect{
    //遍历保存的路径
    for (MyBezierPath * path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            //如果是图片绘制图片
            UIImage * image = (UIImage *)path;            
            [image drawAtPoint:CGPointZero];           
        }else{
        //不是图片连线          
            [path.pathColor set];         
            [path stroke];
        }
    }
}
```
  - 小功能即对保存路径的数组进行操作重绘调用drawRect即可
```
//清空
-(void)clear{
    //清楚路径数组
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}
//撤销
-(void)undo{
    //删除最后路径数组最后一个元素
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
//橡皮擦
-(void)eraser{
    //一条白色的路径，橡皮假象
    self.pathColor = [UIColor whiteColor];
}
```

Demo地址（https://github.com/heiheiLqq/Quartz-2D-Demo ）
