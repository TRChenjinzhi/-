//
//  MineCell.m
//  FenRun
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "MineCell.h"

@interface MineCell ()

@property (nonatomic,strong)UIImageView*    imagV;
@property (nonatomic,strong)UILabel*        titleLB;

@end

@implementation MineCell

+(CGFloat)cellForHeight{
    return kHeight(50);
}

-(void)setUI{
    UIView* backgroundV = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundV];
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.height.mas_offset( [MineCell cellForHeight] );
    }];
    
    UIImageView* imagV  = [UIImageView new];
    self.imagV          = imagV;
    [imagV setImage:UIImageMake(@"ico_me_about_us")];
    [backgroundV addSubview:imagV];
    [imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    UILabel* titleLB    = [LabelHelper CreateLabelByText:@"123" AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    self.titleLB        = titleLB;
    [backgroundV addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imagV.mas_right).offset(kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    UIImageView* nextImage= [UIImageView new];
    [nextImage setImage:UIImageMake(@"ico_service_open")];
    [backgroundV addSubview:nextImage];
    [nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundV.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    UIView* line        = [UIView new];
    line.backgroundColor= LineColor;
    [backgroundV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(backgroundV);
        make.height.mas_offset(LineHight);
    }];
}

-(void)setModel:(MineModel *)model{
    
    _model  = model;
    
    self.titleLB.text   = model.title;
    [self.imagV setImage:UIImageMake(model.imagName)];
    
}

@end
