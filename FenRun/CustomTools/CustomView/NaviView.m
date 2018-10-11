//
//  NaviView.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/6.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "NaviView.h"
@interface NaviView ()

@end

@implementation NaviView

-(void)dealloc{
    NSLog(@"naviView销毁");
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIImageView* backImgV   = [UIImageView new];
    self.backgroundImav     = backImgV;
    [backImgV setImage:UIImageMake(@"img_share_head_bg")];
    [self addSubview:backImgV];
    [backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UILabel* title  = [UILabel new];
    self.titleLB    = title;
    title.textColor             = [UIColor whiteColor];
    title.textAlignment         = NSTextAlignmentCenter;
    title.font                  = kFONT(18);
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIButton* backButton    = [UIButton new];
    self.backBtn            = backButton;
    [backButton setImage:UIImageMake(@"btn_me_return") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(12));
        make.top.and.bottom.equalTo(self);
    }];
    
    UIView* line            = [UIView new];
    self.underLine          = line;
    line.backgroundColor    = LineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.equalTo(self);
        make.height.mas_offset(kWidth(1));
    }];
}

-(void)setTitle:(NSString *)title{
    self.titleLB.text   = title;
}

-(void)back{
    if(self.backBlock){
        self.backBlock();
    }
}

-(void)setIsHideBtn:(BOOL)isHideBtn{
    _isHideBtn  = isHideBtn;
    [self.backBtn setHidden:isHideBtn];
}

@end
