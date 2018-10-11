//
//  MyView.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/10.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MyView.h"

@implementation MyView

+(UIView *)CreateViewByTitle:(NSString *)title AndTitleColor:(UIColor *)titleColor AndSubTitle:(NSString *)subTitle AndSubTitleColor:(UIColor *)subTitleColor andHeight:(CGFloat)height andSuperView:(UIView*)superView andTopDistance:(CGFloat)distance{
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = [UIColor whiteColor];
    [superView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(superView);
        make.top.equalTo(superView.mas_bottom).offset(distance);
        make.height.mas_offset(height);
    }];
    
    UILabel* titleLB            = [LabelHelper CreateLabelByText:title AndFont:kFONT(14) AndTextColor:titleColor AndTextAligemt:NSTextAlignmentLeft];
    [backgroundView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView.mas_left).offset(kWidth(12));
        make.centerY.equalTo(backgroundView.mas_centerY);
    }];
    
    UILabel* subTitleLB         = [LabelHelper CreateLabelByText:subTitle AndFont:kFONT(14) AndTextColor:subTitleColor AndTextAligemt:NSTextAlignmentRight];
    subTitleLB.tag              = 1;
    [backgroundView addSubview:subTitleLB];
    [subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundView.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(backgroundView.mas_centerY);
    }];
    
    UIView* line                = [UIView new];
    line.backgroundColor        = LineColor;
    [backgroundView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(backgroundView);
        make.height.mas_offset(LineHight);
    }];
    
    return backgroundView;
}

+(UIView *)CreateViewByTitle:(NSString *)title AndTitleColor:(UIColor *)titleColor andFont:(UIFont *)font andImaviewName:(NSString *)imagVName andHeight:(CGFloat)height andSuperView:(UIView*)superView andTopDistance:(CGFloat)distance andTopView:(UIView*)topVIew
{
    UIView* backGroundView  = [UIView new];
    [superView addSubview:backGroundView];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(superView);
        if(topVIew){
            make.top.equalTo(topVIew.mas_bottom).offset(distance);
        }
        else{
            make.top.equalTo(superView.mas_top).offset(distance);
        }
        make.height.mas_offset(height);
    }];
    
    UIImageView* imgV   = [UIImageView new];
    [imgV setImage:UIImageMake(imagVName)];
    [backGroundView addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backGroundView.mas_left);
        make.centerY.equalTo(backGroundView.mas_centerY);
    }];
    
    UILabel* titleLB    = [LabelHelper CreateLabelByText:title AndFont:font AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    [backGroundView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV.mas_right);
        make.centerY.equalTo(backGroundView.mas_centerY);
    }];
    
    return backGroundView;
}


@end
