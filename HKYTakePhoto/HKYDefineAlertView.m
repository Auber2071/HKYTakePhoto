//
//  HKYDefineAlertView.m
//  HKYTakePhoto
//
//  Created by hankai on 2017/9/20.
//  Copyright © 2017年 Vencent. All rights reserved.
//

#import "HKYDefineAlertView.h"

@interface HKYDefineAlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *photoBtn;
@property (nonatomic, strong) UIView *btnBottomView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIImage *photoImg;


@end

#define titleLabFont [UIFont systemFontOfSize:16.f]
#define btnFont [UIFont systemFontOfSize:14.f]

@implementation HKYDefineAlertView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


+(HKYDefineAlertView *)sharedInstance{
    static HKYDefineAlertView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedInstance;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGBP(0x000000, 0.3);
        [self addSubview:self.alertView];
        [self.alertView addSubview:self.titleLab];
        [self.alertView addSubview:self.photoBtn];
        [self.alertView addSubview:self.btnBottomView];
        [self.btnBottomView addSubview:self.cancelBtn];
        [self.btnBottomView addSubview:self.sureBtn];
        
    }
    return self;
}

-(void)show{
    [self makeKeyWindow];
    self.hidden = NO;
}


-(void)dismiss{
    [self resignKeyWindow];
    self.hidden = YES;
}

-(void)setupAlertViewPhotoImg:(UIImage *)photoImg{
    [self.photoBtn setImage:photoImg forState:UIControlStateNormal];
    self.photoBtn.enabled = NO;
}

#pragma mark - Get Methods

-(UIView *)alertView{
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.bounds = CGRectMake(0, 0, 300, 180);
        _alertView.centerX = SCREEN_WIDTH/2.f;
        _alertView.centerY = SCREEN_HEIGHT/7.f*3;
        _alertView.layer.cornerRadius = 5.f;
        _alertView.layer.masksToBounds = YES;
    }
    return _alertView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.alertView.frame), 0.2*CGRectGetHeight(self.alertView.frame))];
        _titleLab.backgroundColor = UIColorFromRGB(0xf3f3f3);
        _titleLab.text = @"请上传头像";
        _titleLab.textColor = UIColorFromRGB(0x666666);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = titleLabFont;
    }
    return _titleLab;
}

-(UIButton *)photoBtn{
    if (!_photoBtn) {
        CGFloat width = CGRectGetHeight(self.alertView.frame)*0.41;
        _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoBtn setImage:self.photoImg forState:UIControlStateNormal];
        [_photoBtn addTarget:self action:@selector(p_takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [_photoBtn setBounds:CGRectMake(0, 0, width, width)];
        _photoBtn.centerX = CGRectGetWidth(self.alertView.frame)/2.f;
        _photoBtn.centerY = CGRectGetHeight(self.alertView.frame)/2.f;
        _photoBtn.layer.cornerRadius = width/2.f;
        _photoBtn.layer.masksToBounds = YES;
    }
    return _photoBtn;
}


-(UIView *)btnBottomView{
    if (!_btnBottomView) {
        CGFloat btnBottomViewHeiht = 0.22*CGRectGetHeight(self.alertView.frame);
        _btnBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.alertView.frame) - btnBottomViewHeiht, CGRectGetWidth(self.alertView.frame), btnBottomViewHeiht)];
        _btnBottomView.backgroundColor = UIColorFromRGB(0xeeeeee);
    }
    return _btnBottomView;
}



-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:btnFont];
        [_cancelBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
        [_cancelBtn addTarget:self action:@selector(p_clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setFrame:CGRectMake(0, 1, CGRectGetWidth(self.btnBottomView.frame)/2.f-0.5, CGRectGetHeight(self.btnBottomView.frame))];
    }
    return _cancelBtn;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:btnFont];
        [_sureBtn setTitleColor:UIColorFromRGB(0x1c85fa) forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:[UIColor whiteColor]];
        [_sureBtn addTarget:self action:@selector(p_clickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setFrame:CGRectMake(CGRectGetMaxX(self.cancelBtn.frame)+1, CGRectGetMinY(self.cancelBtn.frame), CGRectGetWidth(self.btnBottomView.frame) - CGRectGetWidth(self.cancelBtn.frame), CGRectGetHeight(self.cancelBtn.frame))];
    }
    return _sureBtn;
}

-(UIImage *)photoImg{
    if (!_photoImg) {
        _photoImg = [UIImage imageNamed:@"lan"];
    }
    return _photoImg;
}


#pragma mark - Private Methods

-(void)p_clickCancelBtn:(UIButton *)sender{
    if (self.alertViewDelegate && [self.alertViewDelegate respondsToSelector:@selector(alertViewCancelAction)]) {
        [self.alertViewDelegate alertViewCancelAction];
    }
    self.photoBtn.enabled = YES;
    [self.photoBtn setImage:self.photoImg forState:UIControlStateNormal];
}

-(void)p_clickSureBtn:(UIButton *)sender{
    if (self.alertViewDelegate && [self.alertViewDelegate respondsToSelector:@selector(alertViewSureAction)]) {
        [self.alertViewDelegate alertViewSureAction];
    }
}

-(void)p_takePhoto:(UIButton *)sender{
    if (self.alertViewDelegate && [self.alertViewDelegate respondsToSelector:@selector(alertViewTakePhotoAction)]) {
        [self.alertViewDelegate alertViewTakePhotoAction];
    }
    [self dismiss];
}

@end
