//
//  ClipScreenViewController.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "ClipScreenViewController.h"

@interface ClipScreenViewController ()

@end

@implementation ClipScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)clipScreen:(id)sender {
    
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
    
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
//    //image转data 首先得知道一种什么样格式的图片
//    NSData * data = UIImagePNGRepresentation(image);
//    //写入桌面
//    [data writeToFile:@"/Users/zzh/Desktop/view.png" atomically:YES];

    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    } else {
        NSLog(@"保存成功");
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
