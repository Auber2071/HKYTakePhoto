//
//  HKYDefineImagePickerController.m
//  HKYTakePhoto
//
//  Created by hankai on 2017/9/20.
//  Copyright © 2017年 Vencent. All rights reserved.
//

#import "HKYDefineImagePickerController.h"

@interface HKYDefineImagePickerController ()

@end

@implementation HKYDefineImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *userNameLab = [[UILabel alloc] init];
    userNameLab.text = @"韩开";
    userNameLab.textColor = [UIColor whiteColor];
    userNameLab.font = [UIFont systemFontOfSize:12.f];
    userNameLab.textAlignment = NSTextAlignmentRight;
    userNameLab.frame = CGRectMake(SCREEN_WIDTH - 60, 200, 60, 30);
    [self.view addSubview:userNameLab];
    
    
    UILabel *addressLab = [[UILabel alloc] init];
    addressLab.textColor = [UIColor whiteColor];
    addressLab.textAlignment = NSTextAlignmentRight;
    addressLab.font = [UIFont systemFontOfSize:12.f];
    addressLab.text = @"北京市朝阳区来广营镇创达路朝来高科技产业园东区";
    addressLab.frame = CGRectMake(0, 240, SCREEN_WIDTH, 30);
    [self.view addSubview:addressLab];
    
}


@end
