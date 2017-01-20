//
//  DrawView.h
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
@property (nonatomic,assign)CGFloat lineWidth;
@property (nonatomic,strong)UIColor * pathColor;
@property (nonatomic,strong)UIImage * image;

- (void)clear;

- (void)undo;
- (void)eraser;
//- (void)picker;
- (void)save;

@end
