//
//  MIneContactVC.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/12.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "MIneContactVC.h"

@interface MIneContactVC ()

@end

@implementation MIneContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    IMP_BLOCK_SELF(MIneContactVC)
    self.naviView.title = @"联系客服";
    self.naviView.backBlock = ^{
        [block_self.navigationController popViewControllerAnimated:YES];
    };
    
    UIView* shouHouV        = [self createViewByTitle:@"宜商通售后" andSuperView:self.naviView andClickBlock:^{
        DeviceTools* tool   = [DeviceTools new];
        tool.superSelf      = block_self;
        [tool CallByPhoneNumber:@"123"];
    }];
    
    UIView* zhaoShangV      = [self createViewByTitle:@"宜商通招商" andSuperView:shouHouV andClickBlock:^{
        DeviceTools* tool   = [DeviceTools new];
        tool.superSelf      = block_self;
        [tool CallByPhoneNumber:@"456"];
    }];
    
    [self createViewByTitle:@"技术支持" andSuperView:zhaoShangV andClickBlock:^{
        DeviceTools* tool   = [DeviceTools new];
        tool.superSelf      = block_self;
        [tool CallByPhoneNumber:@"789"];
    }];
}

-(UIView*)createViewByTitle:(NSString*)title andSuperView:(UIView*)superView andClickBlock:(void(^)(void))clickBlock{
    UIView* backgroundV     = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundV];
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(kHeight(50));
        make.top.equalTo(superView.mas_bottom).offset(kHeight(12));
    }];
    
    UILabel* titleLB        = [LabelHelper CreateLabelByText:title AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    [backgroundV addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    UIImageView* nextImagV  = [UIImageView new];
    [nextImagV setImage:UIImageMake(@"ico_service_open")];
    [backgroundV addSubview:nextImagV];
    [nextImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundV.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    [backgroundV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        
        clickBlock();
    }] ];
    
    return backgroundV;
}

@end
