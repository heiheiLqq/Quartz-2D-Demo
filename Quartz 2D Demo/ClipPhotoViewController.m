//
//  ClipPhotoViewController.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "ClipPhotoViewController.h"

@interface ClipPhotoViewController ()
//图片的截取
@property (nonatomic,assign)CGPoint startP;
@property (nonatomic,weak)UIView * clipView;
@property (nonatomic,weak)UIImageView * imageView;
@end

@implementation ClipPhotoViewController

//图片截取
-(void)viewDidLoad{
    
    [super viewDidLoad];
    //创建一个全屏的图片
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"火影"];
    self.imageView = imageView;
    [self.view addSubview:imageView];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    [self.view addGestureRecognizer:pan];
    
    
}
-(UIView *)clipView{
    
    if (!_clipView) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        _clipView = view;
        [self.view addSubview:_clipView];
        
    }
    
    return _clipView;
}
- (void)pan:(UIPanGestureRecognizer *)pan{
    
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


@end
