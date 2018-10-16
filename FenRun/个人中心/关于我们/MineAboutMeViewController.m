//
//  MineAboutMeViewController.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/14.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MineAboutMeViewController.h"

@interface MineAboutMeViewController ()

@end

@implementation MineAboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    IMP_BLOCK_SELF(MineAboutMeViewController)
    self.naviView.title = @"关于我们";
    self.naviView.backBlock = ^{
        [block_self.navigationController popViewControllerAnimated:YES];
    };
    
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
    
    UIImageView* iconImagV  = [UIImageView new];
    [iconImagV setImage:UIImageMake(@"login_desk_icon")];
    [backgroundView addSubview:iconImagV];
    [iconImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView.mas_top).offset(kWidth(200));
        make.centerX.equalTo(backgroundView.mas_centerX);
        make.height.and.width.mas_offset(kWidth(48));
    }];
    
    UILabel* tips           = [LabelHelper CreateLabelByText:[NSString stringWithFormat:@"%@v%@",[DeviceTools getAPPName],[DeviceTools getAPPVersion]] AndFont:kFONT(16) AndTextColor:APPSubTextColor AndTextAligemt:NSTextAlignmentCenter];
    [backgroundView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImagV.mas_bottom).offset(kWidth(10));
        make.centerX.equalTo(backgroundView.mas_centerX);
    }];
}

@end
