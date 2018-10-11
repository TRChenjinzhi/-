//
//  HomeMachineMyShopCollectionViewCell.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/14.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "HomeMachineMyShopCollectionViewCell.h"
@interface HomeMachineMyShopCollectionViewCell ()

@property (nonatomic,strong)UIImageView*    imagV;
@property (nonatomic,strong)UILabel*        nameLB;
@property (nonatomic,strong)UILabel*        moneyLB;

@end

@implementation HomeMachineMyShopCollectionViewCell

+(HomeMachineMyShopCollectionViewCell*)getCellBy:(UICollectionView*)collectionView AndIdentify:(NSString*)identify AndIndexpath:(NSIndexPath*)indexPath{
    HomeMachineMyShopCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if(!cell){
        cell = [[HomeMachineMyShopCollectionViewCell alloc] init];
    }
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    
    self.backgroundColor    = [UIColor whiteColor];
    
    UIImageView* imagV = [UIImageView new];
    self.imagV = imagV;
    [self addSubview:imagV];
    [imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.height.mas_offset(kWidth(160));
    }];
    
    self.nameLB             = [LabelHelper CreateLabelByText:@";;" AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    self.nameLB.numberOfLines= 2;
    [self addSubview:self.nameLB];
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(12));
        make.right.equalTo(self.mas_right);
        make.top.equalTo(imagV.mas_bottom).offset(kWidth(16));
    }];
    
    self.moneyLB            = [LabelHelper CreateLabelByText:@"123" AndFont:kFONT(14) AndTextColor:APPThemeBlue AndTextAligemt:NSTextAlignmentLeft];
    [self addSubview:self.moneyLB];
    [self.moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(12));
        make.bottom.equalTo(self.mas_bottom).offset(-kWidth(12));
    }];
}

-(void)setModel:(MyCollectionModel *)model{
    [self.imagV sd_setImageWithURL:[NSURL URLWithString:model.goods_pic] placeholderImage:UIImageMake(@"img_product_cart_images")];
    self.nameLB.text        = model.goods_name;
    self.moneyLB.text       = [NSString stringWithFormat:@"¥%.2f",model.goods_money];
}


@end
