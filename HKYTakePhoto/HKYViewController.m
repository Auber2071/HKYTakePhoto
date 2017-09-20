//
//  HKYViewController.m
//  HKYTakePhoto
//
//  Created by hankai on 2017/9/20.
//  Copyright © 2017年 Vencent. All rights reserved.
//

#import "HKYViewController.h"
#import "HKYDefineImagePickerController.h"
#import "HKYDefineAlertView.h"


@interface HKYViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HKYDefineAlertViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) HKYDefineAlertView *defineAlertView;

@end

@implementation HKYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(p_showAlertView)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

-(void)p_showAlertView{
    [self.defineAlertView show];
}

-(void)p_takePhoto{
    HKYDefineImagePickerController *imagePicker = [[HKYDefineImagePickerController alloc] init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取照相机使用权限失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
        [alertController addAction:cancelAction];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.defineAlertView show];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *originalImage;
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.defineAlertView show];
    UIImage *tempImg =[UIImage imageWithData: UIImageJPEGRepresentation(originalImage,0.5)];
    [self.defineAlertView setupDefineAlertViewPhotoImg:tempImg];

}

#pragma mark - HKYDefineAlertViewDelegate
- (void)defineAlertView:(HKYDefineAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {//取消
        
    }else if (buttonIndex == 1){//确定
        [self.defineAlertView dismiss];
    }else if (buttonIndex ==2){
        [self p_takePhoto];
    }
}

#pragma mark - HKYAlert
-(HKYDefineAlertView *)defineAlertView{
    if (!_defineAlertView) {
        _defineAlertView = [[HKYDefineAlertView alloc] initWithTitle:@"请上传头像" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
    }
    return _defineAlertView;
}
@end
