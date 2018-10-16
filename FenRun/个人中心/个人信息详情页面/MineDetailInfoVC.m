//
//  MineDetailInfoVC.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "MineDetailInfoVC.h"

@interface MineDetailInfoVC ()

@end

@implementation MineDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

-(void)setUI{
    IMP_BLOCK_SELF(MineDetailInfoVC)
    self.naviView.title = @"个人信息";
    self.naviView.backBlock = ^{
        [block_self.navigationController popViewControllerAnimated:YES];
    };
    
    UIView* userInfoV   = [self createImageView];
    UIView* phoneV      = [self createViewByTitle:@"联系方式" andSubTitle:[LoginHelper share].user_phone andSuperView:userInfoV];
    [self createViewByTitle:@"所在地址" andSubTitle:[LoginHelper share].address andSuperView:phoneV];
}

-(UIView*)createImageView{
    UIView* backgroundV = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundV];
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.naviView.mas_bottom);
        make.height.mas_offset(kHeight(80));
    }];
    
    UIImageView* icon   = [UIImageView new];
    icon.userInteractionEnabled = YES;
    if([[LoginHelper share] HaveIcon]){
        [icon sd_setImageWithURL:[NSURL URLWithString:[LoginHelper share].user_pic]];
    }
    else{
        [icon setImage:UIImageMake(@"img_me_head_image")];
    }
    [icon.layer setCornerRadius:kHeight(48)/2];
    icon.layer.masksToBounds    = YES;
    [backgroundV addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(12));
        make.width.and.height.mas_offset(kHeight(48));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    UIImageView* camareImagV    = [UIImageView new];
    [camareImagV setImage:UIImageMake(@"ico_me_head_image_camera")];
    [backgroundV addSubview:camareImagV];
    [camareImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(icon.mas_bottom);
        make.right.equalTo(icon.mas_right).offset(kWidth(4));
    }];
    
    IMP_BLOCK_SELF(MineDetailInfoVC)
    [icon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        NSLog(@"选择照片");
        [MyWindow showSheetWindownByTitle:@"请选择" andBottonTitleArray:@[@"相机",@"相册"] andSuper:block_self Sucess:^(NSString *title) {
            if([title isEqualToString:@"相册"]){
                [CameraHelper sharedInstance].vc    = block_self;
                [CameraHelper sharedInstance].type  = CameraPhotos;
                [CameraHelper sharedInstance].didfinishedBlock = ^(UIImage *image) {
                    NSLog(@"照片选取完毕");
                };
                [[CameraHelper sharedInstance] getImageFromCamera];
            }
            else if([title isEqualToString:@"相机"]){
                [CameraHelper sharedInstance].vc    = block_self;
                [CameraHelper sharedInstance].type  = CameraMine;
                [CameraHelper sharedInstance].didfinishedBlock = ^(UIImage *image) {
                    NSLog(@"牌照选取完毕");
                };
                [[CameraHelper sharedInstance] getImageFromCamera];
            }
        } AndFailed:^{
            
        }];
        
    }] ];
    
    UILabel* nameLB     = [LabelHelper CreateLabelByText:[LoginHelper share].user_name AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentRight];
    [backgroundV addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundV.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    UIView* line        = [UIView new];
    line.backgroundColor= LineColor;
    [backgroundV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(backgroundV);
        make.height.mas_offset(LineHight);
    }];
    
    return backgroundV;
}

-(UIView*)createViewByTitle:(NSString*)title andSubTitle:(NSString*)subTitle andSuperView:(UIView*)superView{
    UIView* backgroundV = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundV];
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(superView.mas_bottom);
        make.height.mas_offset(kHeight(50));
    }];
    
    UILabel* titleLB    = [LabelHelper CreateLabelByText:title AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    [backgroundV addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    UILabel* subTitleLB = [LabelHelper CreateLabelByText:subTitle AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentRight];
    [backgroundV addSubview:subTitleLB];
    [subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundV.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    UIView* line        = [UIView new];
    line.backgroundColor= LineColor;
    [backgroundV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(backgroundV);
        make.height.mas_offset(LineHight);
    }];
    
    return backgroundV;
}

@end
