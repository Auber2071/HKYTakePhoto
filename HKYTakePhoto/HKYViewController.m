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


@interface HKYViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HKYDefineAlertViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) HKYDefineAlertView *defineAlertView;

@end

@implementation HKYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(p_showAlertView)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
     
    [self.view addSubview:self.imageView];
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *originalImage;
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
//    __weak typeof(self) tempSelf = self;
//    [picker dismissViewControllerAnimated:YES completion:^{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            UIImage *tempImg =[UIImage imageWithData: UIImageJPEGRepresentation(originalImage,0.5)];
//            [tempSelf.defineAlertView setupAlertViewPhotoImg:tempImg];
//        });
//    }];
    
    [self.defineAlertView show];
    UIImage *tempImg =[UIImage imageWithData: UIImageJPEGRepresentation(originalImage,0.5)];
    [self.defineAlertView setupAlertViewPhotoImg:tempImg];

}

#pragma mark - HKYDefineAlertViewDelegate
-(void)alertViewCancelAction{
    [self.defineAlertView dismiss];
}
-(void)alertViewSureAction{
    //打卡成功消失
    [self.defineAlertView dismiss];
}
-(void)alertViewTakePhotoAction{
    [self p_takePhoto];
}

#pragma mark - HKYAlert
-(HKYDefineAlertView *)defineAlertView{
    if (!_defineAlertView) {
        _defineAlertView = [[HKYDefineAlertView alloc] initWithFrame:self.view.bounds];
        _defineAlertView.alertViewDelegate = self;
    }
    return _defineAlertView;
}
@end
