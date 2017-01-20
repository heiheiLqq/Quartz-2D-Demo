//
//  ClearPhotoViewController.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "ClearPhotoViewController.h"

@interface ClearPhotoViewController ()
//图片的擦除
@property (nonatomic,weak)UIImageView * imageA;
@property (nonatomic,weak)UIImageView * imageB;
@end

@implementation ClearPhotoViewController

//图片擦除
-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageB = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.imageB = imageB;
    self.imageB.image = [UIImage imageNamed:@"2B"];
    [self.view addSubview:imageB];
    
    UIImageView * imageA = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.imageA = imageA;
    self.imageA.image = [UIImage imageNamed:@"2A"];
    [self.view addSubview:imageA];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    [self.view addGestureRecognizer:pan];
    
    
    
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
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


@end
