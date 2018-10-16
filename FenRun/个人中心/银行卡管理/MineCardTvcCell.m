//
//  MineCardTvcCell.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/27.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MineCardTvcCell.h"

@interface MineCardTvcCell ()
@property (nonatomic,strong) UIImageView*   imgV;
@property (nonatomic,strong) UILabel*       bankNameLB;
@property (nonatomic,strong) UILabel*       bankNumberLB;
@property (nonatomic,strong) UIImageView*   defaultImagV;
@end

static NSString* ID = @"MineCardTvcCell";

@implementation MineCardTvcCell

+(CGFloat)HieghtForCell{
    return kWidth(120+20);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    MineCardTvcCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (cell == nil) {
        cell = [[MineCardTvcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = APPThemeGray;
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.height.mas_offset([MineCardTvcCell HieghtForCell]);
    }];
    
    UIImageView* backGroundImag= [UIImageView new];
    self.imgV                   = backGroundImag;
    [backgroundView addSubview:backGroundImag];
    [backGroundImag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView.mas_top).offset(kWidth(20));
        make.left.equalTo(backgroundView.mas_left).offset(kWidth(12));
        make.right.equalTo(backgroundView.mas_right).offset(-kWidth(12));
        make.bottom.equalTo(backgroundView.mas_bottom);
    }];
    
    UILabel* nameLB         = [LabelHelper CreateLabelByText:@"123" AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    self.bankNameLB         = nameLB;
    [backGroundImag addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backGroundImag.mas_left).offset(kWidth(12));
        make.top.equalTo(backGroundImag.mas_top).offset(kWidth(12));
    }];
    
    UILabel* bankNumber     = [LabelHelper CreateLabelByText:@"123" AndFont:KBFONT(24) AndTextColor:APPThemeBlue AndTextAligemt:NSTextAlignmentLeft];
    self.bankNumberLB       = bankNumber;
    [backGroundImag addSubview:bankNumber];
    [bankNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backGroundImag.mas_left).offset(kWidth(12));
        make.centerY.equalTo(backGroundImag.mas_centerY);
    }];
    
    UIImageView* defaultImg = [UIImageView new];
    self.defaultImagV       = defaultImg;
    [defaultImg setImage:UIImageMake(@"ico_bank_card_translate")];
    [backGroundImag addSubview:defaultImg];
    [defaultImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backGroundImag.mas_right).offset(-kWidth(12));
        make.bottom.equalTo(backGroundImag.mas_bottom).offset(-kWidth(12));
    }];
}

-(void)setModel:(MineCardControlCellModel *)model{
    _model  = model;
    
    self.bankNameLB.text    = model.bank_name;
    self.bankNumberLB.text  = [LoginRule getCardStringByCardList:model.userBankNumber];
    [self.defaultImagV setHidden:!model.isDefault];
    
    if(self.tag == 0){
        [self.imgV setImage:UIImageMake(@"img_bank_card_bg")];
    }
    else if(self.tag == 1){
        [self.imgV setImage:UIImageMake(@"img_bank_card_bg")];
    }
    else if(self.tag == 2){
        [self.imgV setImage:UIImageMake(@"img_bank_card_bg")];
    }
    else if(self.tag == 3){
        [self.imgV setImage:UIImageMake(@"img_bank_card_bg")];
    }
    else{
        [self.imgV setImage:UIImageMake(@"img_bank_card_bg")];
    }
    
}



@end
