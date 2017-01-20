//
//  CirclePhotoViewController.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "CirclePhotoViewController.h"

@interface CirclePhotoViewController ()

@end

@implementation CirclePhotoViewController

//裁剪后的圆形头像加一个圆边
-(void)viewDidLoad{

    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
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

}



////图片裁剪 APP中原型头像
//-(void)viewDidLoad{
//
//    [super viewDidLoad];
//
//    //创建一个imageview
//    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
//    imageView.center = self.view.center;
//    [self.view addSubview:imageView];
//
//    //图片裁剪，把正方形图片重新生成一张圆形图片，
//
//    //0加载一张图片
//    UIImage * image = [UIImage imageNamed:@"阿狸头像"];
//    //1开启一个位图上下文，跟图片尺寸一样大
//    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
//    //2设置圆形裁剪区域，正切与图片
//    //    UIRectClip()只能裁剪矩形
//    //创建圆形裁剪区域
//    //2.1创建圆形路径
//    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width,image.size.height )];
//    //2.2把路径设置为裁剪区域
//    [path addClip];
//    //3 绘制图片
//    [image drawAtPoint:CGPointZero];
//    //4上下文获取图片
//    UIImage * clipImage = UIGraphicsGetImageFromCurrentImageContext();
//    //关闭上下文
//    UIGraphicsEndImageContext();
//
//    imageView.image = clipImage;
//
//}
//


@end
