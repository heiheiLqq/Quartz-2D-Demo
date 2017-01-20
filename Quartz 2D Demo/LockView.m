//
//  LockView.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "LockView.h"

@interface LockView ()
@property (nonatomic,copy)NSMutableArray * selectsBtn;
@property (nonatomic,assign)CGPoint fingerPoint;

@end


@implementation LockView
#pragma mark - 构造方法
- (instancetype)init{

    self = [super init];

    if (self!= nil) {
    
        [self setup];
    }

    return self;
    
}
#pragma mark - 懒加载
//记录手指划过的按钮
- (NSMutableArray *)selectsBtn{

    if (!_selectsBtn) {
        _selectsBtn = [NSMutableArray array];
    }

    return _selectsBtn;
}
#pragma mark - 初始化 创建9个按钮 和pan手势
- (void)setup{

    self.backgroundColor = [UIColor clearColor];
    
    for (int i = 0 ; i < 9; i ++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        btn.tag = i;
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
    
    }
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self addGestureRecognizer:pan];
    

}
- (void)pan:(UIPanGestureRecognizer *)pan{

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
#pragma mark - 绘图
-(void)drawRect:(CGRect)rect{

    
    if (self.selectsBtn.count==0) return;
    
    UIBezierPath * patn = [UIBezierPath bezierPath];
    //遍历选中数组中的按钮
    for (int i = 0 ; i < self.selectsBtn.count; i++) {
        
        UIButton * btn = self.selectsBtn[i];
        
        if (i== 0) {
        
            //如果是第一个按钮作为 线的起点
            [patn moveToPoint:btn.center];
        }else{
        
            //线的终点
            [patn addLineToPoint:btn.center];
        }
        
    }
    
    //如果手指不是在按钮内 连线按钮和手指
    [patn addLineToPoint:self.fingerPoint];

    //设置线的颜色
    [[UIColor greenColor] set];
    //线宽
    patn.lineWidth = 10;
    patn.lineJoinStyle = kCGLineJoinRound;
    //连线
    [patn stroke];

}
#pragma mark - 九宫格布局
-(void)layoutSubviews{

    [super layoutSubviews];
    //九宫格布局
    CGFloat col = 3;
    CGFloat width = 74;
    CGFloat height = 74;
    CGFloat margin = (self.frame.size.width - col*width)/(col+1);
    CGFloat x= 0;
    CGFloat y = 0;
    
    for (NSInteger i = 0; i< self.subviews.count; i++) {
        
        UIButton * btn = self.subviews[i];
        
        x =  margin* (i%3+1)+width*(i%3);
        y = margin* (i/3+1)+width*(i/3);
        btn.frame = CGRectMake(x, y, width, height);
        
        
        
    }
    


}

@end
