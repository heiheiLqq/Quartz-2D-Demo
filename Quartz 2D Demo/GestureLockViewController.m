//
//  GestureLockViewController.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "GestureLockViewController.h"
#import "LockView.h"

@interface GestureLockViewController ()

@end

@implementation GestureLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    
    LockView * lock = [[LockView alloc]init];
    lock.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    lock.center = self.view.center;
    [self.view addSubview:lock];
    
}



@end
