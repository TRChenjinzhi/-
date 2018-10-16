//
//  MineWordOrderCell.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/12.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "MineWordOrderCell.h"

@interface MineWordOrderCell ()

@property (nonatomic,strong)UILabel*    numberLB;
@property (nonatomic,strong)UILabel*    dateLB;
@property (nonatomic,strong)UILabel*    typeLB;
@property (nonatomic,strong)UILabel*    resultLB;

@end

@implementation MineWordOrderCell

+(CGFloat)cellForHeight{
    return kHeight(70);
}

-(void)setUI{
    UIView* backgroundV     = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self addSubview:backgroundV];
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.height.mas_offset( [MineWordOrderCell cellForHeight] );
    }];
    
    UILabel* numberLB       = [LabelHelper CreateLabelByText:@"123" AndFont:kFONT(12) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    self.numberLB           = numberLB;
    [backgroundV addSubview:numberLB];
    [numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(12));
        make.top.equalTo(backgroundV.mas_top).offset(kWidth(12));
    }];
    
    UILabel* dateLB         = [LabelHelper CreateLabelByText:@"456" AndFont:kFONT(12) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentRight];
    self.dateLB             = dateLB;
    [backgroundV addSubview:dateLB];
    [dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundV.mas_right).offset(-kWidth(12));
        make.top.equalTo(backgroundV.mas_top).offset(kWidth(12));
    }];
    
    UILabel* typeLB         = [LabelHelper CreateLabelByText:@"789" AndFont:kFONT(12) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    self.typeLB             = typeLB;
    [backgroundV addSubview:typeLB];
    [typeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(12));
        make.top.equalTo(numberLB.mas_bottom).offset(kWidth(17));
    }];
    
    UILabel* stateLB        = [LabelHelper CreateLabelByText:@"987" AndFont:kFONT(12) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentRight];
    self.resultLB           = stateLB;
    [backgroundV addSubview:stateLB];
    [stateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundV.mas_right).offset(-kWidth(12));
        make.top.equalTo(dateLB.mas_bottom).offset(kWidth(17));
    }];
}

-(void)setModel:(MineWordOrderModel *)model{
    self.numberLB.text      = [NSString stringWithFormat:@"工单号：%@",model.number];
    self.dateLB.text        = model.date;
    switch (model.type) {
        case POS:
        {
            self.typeLB.text= @"类型：调单大POS";
            break;
        }
        case Hander:
        {
            self.typeLB.text= @"类型：调单手刷";
            break;
        }
        case BlackMenu:
        {
            self.typeLB.text= @"类型：黑名单解冻";
            break;
        }
            
        default:
            break;
    }
    
    switch (model.state) {
        case sucess:
        {
            self.resultLB.text= @"成功";
            self.resultLB.textColor = RGBA(58, 191, 80, 1);
            break;
        }
        case failed:
        {
            self.resultLB.text= @"失败";
            self.resultLB.textColor = RGBA(255, 86, 80, 76);
            break;
        }
        case Doing:
        {
            self.resultLB.text= @"待处理";
            self.resultLB.textColor = RGBA(255, 86, 80, 76);
            break;
        }
            
        default:
            break;
    }
}

@end
