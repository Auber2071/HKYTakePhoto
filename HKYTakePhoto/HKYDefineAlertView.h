//
//  HKYDefineAlertView.h
//  HKYTakePhoto
//
//  Created by hankai on 2017/9/20.
//  Copyright © 2017年 Vencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKYDefineAlertView;

@protocol HKYDefineAlertViewDelegate <NSObject>

-(void)alertViewCancelAction;
-(void)alertViewSureAction;
-(void)alertViewTakePhotoAction;

@end

@interface HKYDefineAlertView : UIWindow
@property (nonatomic, assign) id<HKYDefineAlertViewDelegate> alertViewDelegate;

//+(HKYDefineAlertView *)sharedInstance;

-(void)setupAlertViewPhotoImg:(UIImage *)photoImage;
-(void)show;
-(void)dismiss;

@end
