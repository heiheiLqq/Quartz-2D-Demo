//
//  GestureRecognizerViewController.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/22.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "GestureRecognizerViewController.h"

@interface GestureRecognizerViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation GestureRecognizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.imageView.userInteractionEnabled = YES;
    
    //pan手势 移动位置
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    
    [self.imageView addGestureRecognizer:pan];
    //rotation旋转手势
    UIRotationGestureRecognizer * rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    
    [self.imageView addGestureRecognizer:rotation];
    //pinch捏合手势
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    
    [self.imageView addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    
    [self.imageView addGestureRecognizer:longPress];

}
- (void)longPress:(UILongPressGestureRecognizer *)longPress{

    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.alpha = 0;
    } completion:^(BOOL finished) {
       
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.alpha = 1;
        } completion:^(BOOL finished) {
            
            
        }];
    }];
    

}

- (void)pan:(UIPanGestureRecognizer * )pan{

    CGPoint transP = [pan translationInView:self.imageView];
    
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, transP.x, transP.y);
    
    [pan setTranslation:CGPointZero inView:self.imageView];
    
}

- (void)rotation:(UIRotationGestureRecognizer * )rotation{
    
    
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    
    rotation.rotation = 0;
    
}
- (void)pinch:(UIPinchGestureRecognizer * )pinch{
    
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    
    pinch.scale = 1;
    
}
//是否支持多个手势同时出发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return YES;

}
@end
