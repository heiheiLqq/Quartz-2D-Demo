//
//  ViewController.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "ViewController.h"
#import "WaterPhotoViewController.h"
#import "ClipPhotoViewController.h"
#import "CirclePhotoViewController.h"
#import "ClipScreenViewController.h"
#import "ClearPhotoViewController.h"
#import "GestureLockViewController.h"
#import "DrawingBoardViewController.h"
#import "GestureRecognizerViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView * tableView;
@property (nonatomic,copy)NSArray * dataSource;





@end

@implementation ViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
    

}
-(NSArray *)dataSource{

    if (!_dataSource) {
        
        _dataSource = @[@"图片水印",@"图片裁剪",@"屏幕截屏",@"图片截取",@"图片擦除",@"手势解锁",@"画板",@"手势处理"];
    }
    return _dataSource;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.row == 0) {
        
        WaterPhotoViewController * waterPhoto = [[WaterPhotoViewController alloc]init];
        waterPhoto.title = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:waterPhoto animated:YES];
        
        
    }else if (indexPath.row == 1){
    
        CirclePhotoViewController * circlePhoto = [[CirclePhotoViewController alloc]init];
        circlePhoto.title = self.dataSource[indexPath.row];

        [self.navigationController pushViewController:circlePhoto animated:YES];
        
    }else if (indexPath.row == 2){
    
        ClipScreenViewController * clipScreen = [[ClipScreenViewController alloc]init];
        clipScreen.title = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:clipScreen animated:YES];
        
    }else if (indexPath.row == 3){
    
        ClipPhotoViewController * clipPhoto = [[ClipPhotoViewController alloc]init];
        clipPhoto.title = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:clipPhoto animated:YES];
    }else if (indexPath.row == 4){
    
        ClearPhotoViewController * clearPhoto = [[ClearPhotoViewController alloc]init];
        clearPhoto.title = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:clearPhoto animated:YES];
        
        
    }else if (indexPath.row == 5){
    
        GestureLockViewController * lock = [[GestureLockViewController alloc]init];
        lock.title = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:lock animated:YES];
        
    }else if(indexPath.row == 6){
        DrawingBoardViewController * drawBoard = [[DrawingBoardViewController alloc]init];
        drawBoard.title = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:drawBoard animated:YES];
    
    }else{
        GestureRecognizerViewController * drawBoard = [[GestureRecognizerViewController alloc]init];
        drawBoard.title = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:drawBoard animated:YES];
        
    
        
    }


}




















@end
