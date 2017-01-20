//
//  DrawView.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "DrawView.h"
#import "MyBezierPath.h"
@interface DrawView ()

@property (nonatomic,strong)MyBezierPath * path;

@property (nonatomic, copy)NSMutableArray * paths;

@end

@implementation DrawView
#pragma mark - xib 初始化完成
- (void)awakeFromNib{

    [super awakeFromNib];
    
    [self setup];
}
#pragma mark - 代码构造函数
- (instancetype)initWithFrame:(CGRect)frame{


    self = [super initWithFrame:frame];
    
    if (!self) {
        [self setup];
    }

    return self;
}
#pragma mark - 初始化一些设置
- (void)setup{

    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self addGestureRecognizer:pan];
    self.lineWidth = 1;
    self.pathColor = [UIColor blackColor];

}
#pragma mark - 手势事件
- (void)pan:(UIPanGestureRecognizer *)pan{

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
#pragma mark - 重新绘制
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
#pragma mark - 懒加载 保存路径的数组
- (NSMutableArray *)paths{


    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;

}
#pragma mark - image的set方法
-(void)setImage:(UIImage *)image{

    _image = image;
    
    //把图片加入到数组张
    [self.paths addObject:image];
    //重新绘制
    [self setNeedsDisplay];

}
#pragma mark - 清空
- (void)clear{

    //清楚路径数组
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}
#pragma mark - 撤销
- (void)undo{

    //删除最后路径数组最后一个元素
    [self.paths removeLastObject];
    [self setNeedsDisplay];

}
#pragma mark - 橡皮擦
- (void)eraser{

    //一条白色的路径，橡皮假象
    self.pathColor = [UIColor whiteColor];
}
#pragma mark -保存
- (void)save{

    //截屏
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //渲染图层
    [self.layer renderInContext:ctx];
    //获取上下文中的图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    //保存到相册中
    //image：写入图片
    //conmpletionTargert 图片保存成功监听这
    //注意 以后写入相册房中，想要监听图片保存完成的方法不能随意乱写，必须实现规定方法
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    


}
#pragma mark - 保存回到方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    } else {
        NSLog(@"保存成功");
    }
    
}
@end
