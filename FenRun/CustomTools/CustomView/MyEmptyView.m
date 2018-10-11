//
//  MyEmptyView.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/22.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MyEmptyView.h"

@interface MyEmptyView ()

@property (nonatomic,strong)UIImageView* imgV;

@end

@implementation MyEmptyView

-(instancetype)initWithImage:(UIImage*)img{
    self = [[MyEmptyView alloc] init];
    if(self){
        [self setUI:img];
    }
    return self;
}

-(instancetype)initWithByFrame:(CGRect)frame{
    self    = [super initWithFrame:frame];
    if(self){
        [self setUIByFrame:UIImageMake(@"img_defect_empty_data")];
    }
    return self;
}

-(void)setUI:(UIImage*)img{
    if(self.imgV){
        return;
    }
    self.imgV   = [UIImageView new];
    [self.imgV setImage:img];
    [self addSubview:self.imgV];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
//        make.width.and.height.mas_offset(kWidth(200));
    }];
}

-(void)setUIByFrame:(UIImage*)img{
    self.imgV   = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth(200), kWidth(200))];
    [self.imgV setImage:img];
    self.imgV.center    = self.center;
    [self addSubview:self.imgV];
}

@end
