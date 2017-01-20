//
//  DrawingBoardViewController.m
//  Quartz 2D Demo
//
//  Created by zzh on 2017/1/20.
//  Copyright © 2017年 zzh. All rights reserved.
//

#import "DrawingBoardViewController.h"
#import "DrawView.h"
@interface DrawingBoardViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation DrawingBoardViewController
#pragma mark - 改变颜色
- (IBAction)colorChange:(UIButton *)sender {
    self.drawView.pathColor = sender.backgroundColor;
}
#pragma mark - 改变线宽
- (IBAction)valueChange:(UISlider*)sender {
    self.drawView.lineWidth =sender.value;
}
#pragma mark - 清空
- (IBAction)clear:(id)sender {
    
    [self.drawView clear];
    
}
#pragma mark - 撤销
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
#pragma mark -橡皮擦
- (IBAction)eraser:(id)sender {
    [self.drawView eraser];
}
#pragma mark - 照片渲染
- (IBAction)picker:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark - 保存
- (IBAction)save:(id)sender {
    [self.drawView  save];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage * image = info[UIImagePickerControllerOriginalImage];
    self.drawView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
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
