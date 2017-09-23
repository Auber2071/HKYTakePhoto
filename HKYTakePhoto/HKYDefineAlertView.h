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

- (void)defineAlertView:(HKYDefineAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface HKYDefineAlertView : UIWindow

- (instancetype)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitle;

-(void)setupDefineAlertViewPhotoImg:(UIImage *)photoImage;
-(void)setupMsg:(NSString *)msg;
-(void)show;
-(void)dismiss;

@end
