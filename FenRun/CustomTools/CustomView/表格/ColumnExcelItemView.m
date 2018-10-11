//
//  ColumnExcelItemView.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/15.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "ColumnExcelItemView.h"

@interface ColumnExcelItemView ()

@property (nonatomic,strong)NSMutableArray* tipsArray;
@property (nonatomic,strong)UIView*         excellView;

@end

@implementation ColumnExcelItemView

-(NSMutableArray *)tipsArray{
    if(!_tipsArray){
        _tipsArray  = [NSMutableArray new];
    }
    return _tipsArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

-(void)clearAll{
    //清除UI
    [self removeAllSubviews];
    
    //清除数据
    [self.tipsArray removeAllObjects];
}

-(void)setUI
{
    //背景颜色
    self.backgroundColor    = self.viewColor;
    
    UIView* columnView      = [UIView new];
    self.excellView         = columnView;
    [self addSubview:columnView];
    [columnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-self.bottomSpace);
    }];
    
    
    //右边分割线
    UIView* line            = [UIView new];
    line.backgroundColor    = RGBA(0xca, 0xca, 0xca, 1);
    [columnView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(columnView.mas_right).offset(-kWidth(1));
        make.width.mas_offset(LineHight);
        make.top.equalTo(columnView);
        make.bottom.equalTo(self.excellView.mas_bottom);
    }];
    
    CGFloat nullSpace       = (self.frame.size.width - self.columNum*self.columWidth) / (self.columNum+1);//间隔距离
    for(int i=0 ;i<self.columNum ;i++){
        
        CGFloat columnHeight    = ( [self.arrayValue[i] floatValue] / self.maxMoney) * (self.frame.size.height-self.bottomSpace);
        
        //圆柱
        UIView* columnView  = [UIView new];
        columnView.backgroundColor  = self.arrayColor[i];
        [self.excellView addSubview:columnView];
        [columnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.excellView.mas_left).offset( (i+1)*nullSpace + i*self.columWidth );
            make.bottom.equalTo(self.excellView.mas_bottom);
            make.width.mas_offset(self.columWidth);
            make.height.mas_offset(columnHeight);
        }];
        
        //标签
        CGFloat value = [self.arrayValue[i] floatValue] / self.maxMoney ;
        UILabel* valueLB            = [LabelHelper CreateLabelByText:[NSString stringWithFormat:@"%.2f",value] AndFont:kFONT(self.tipsFontSize) AndTextColor:self.arrayColor[i] AndTextAligemt:NSTextAlignmentCenter];
        valueLB.backgroundColor     = self.tipsBackgroundColor;
        [valueLB.layer setCornerRadius:self.tipsRadius];
        valueLB.layer.masksToBounds = YES;
        [valueLB setHidden:YES];
        [self.excellView addSubview:valueLB];
        [valueLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(columnView.mas_top).offset(-kWidth(4));
            make.centerX.equalTo(columnView.mas_centerX);
        }];
        
        [self.tipsArray addObject:valueLB];
    }
    
    //横线
    UIView* Xline                   = [UIView new];
    Xline.backgroundColor           = RGBA(0xec, 0xec, 0xec, 1);
    [self.excellView addSubview:Xline];
    [Xline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.excellView);
        make.top.equalTo(self.excellView.mas_bottom);
        make.height.mas_offset(kWidth(2));
    }];
    
    //底部标签
    UILabel* bottomTip              = [LabelHelper CreateLabelByText:self.bottomTip AndFont:kFONT(11) AndTextColor:APPSubTextColor AndTextAligemt:NSTextAlignmentCenter];
    [self addSubview:bottomTip];
    [bottomTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    //添加view的点击方法
    IMP_BLOCK_SELF(ColumnExcelItemView)
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if(block_self.clickBlcok){
            block_self.clickBlcok(block_self.isShow,block_self);
        }
    }]];
}

-(void)setIsShow:(BOOL)isShow{
    _isShow = isShow;
    
    for (UILabel* tipV in self.tipsArray) {
        [tipV setHidden:!isShow];
    }
    
    self.excellView.backgroundColor    = isShow ? APPThemeGray : self.viewColor;
}



@end
