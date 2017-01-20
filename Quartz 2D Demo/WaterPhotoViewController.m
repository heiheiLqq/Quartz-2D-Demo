//
//  WaterPhotoViewController.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "WaterPhotoViewController.h"

@interface WaterPhotoViewController ()

@end

@implementation WaterPhotoViewController

//图片加文字水印
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
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

}



@end
