//
//  IncomeColumnExcellView.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/15.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "IncomeColumnExcellView.h"
#import "ColumnExcelItemView.h"

@interface IncomeColumnExcellView ()

@property (nonatomic,strong)UIScrollView*   scrollview;
@property (nonatomic,strong)NSMutableArray* itemArray;

@end

@implementation IncomeColumnExcellView

-(NSMutableArray *)itemArray{
    if(!_itemArray){
        _itemArray  = [NSMutableArray array];
    }
    return _itemArray;
}

-(UIScrollView *)scrollview{
    if(!_scrollview){
        _scrollview = [UIScrollView new];
        _scrollview.showsVerticalScrollIndicator        = NO;
        _scrollview.showsHorizontalScrollIndicator      = NO;
        _scrollview.bounces                             = NO;
        if (@available(iOS 11.0, *)) {
            _scrollview.contentInsetAdjustmentBehavior      = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return _scrollview;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    }
    return self;
}

-(void)setUI{
    
    [self removeAllSubviews];
    [self.scrollview removeAllSubviews];
    
    CGFloat columnBottomSpace= kWidth(24+2);
    CGFloat maxMoney        = [self getMaxMoney:self.dataSource];
    
    //宽高具体数值比例 -------因为这个都以 宽SCREEN_WIDTH 和 高kWidth(340) 为标准
    CGFloat widthScale      = self.frame.size.width / SCREEN_WIDTH;
    CGFloat heightScale     = self.frame.size.height / kWidth(330);
    
    //背景
    self.backgroundColor    = [UIColor whiteColor];
    
    //Y轴
    UIView* YView           = [UIView new];
    YView.backgroundColor   = RGBA(0xec, 0xec, 0xec, 1);
    [self addSubview:YView];
    [YView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kWidth(30)*widthScale);
        make.top.equalTo(self.mas_top).offset(kWidth(16)*heightScale);
        make.width.mas_offset(kWidth(2)*widthScale);
        make.height.mas_offset(kWidth(250)-(columnBottomSpace-kWidth(2)) );
    }];
    
    CGFloat leftTipsHeight  = (kWidth(250)-columnBottomSpace)/5;
    CGFloat tipsHeight      = [LabelHelper GetLabelHight:kFONT(11) AndText:@"1" AndWidth:kWidth(30)];
    for(int i=0 ;i<6 ;i++){
        UILabel* tipLB      = [LabelHelper CreateLabelByText:[NSString stringWithFormat:@"%d",i*2] AndFont:kFONT(11) AndTextColor:APPSubTextColor AndTextAligemt:NSTextAlignmentCenter];
        [self addSubview:tipLB];
        [tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_left).offset(kWidth(30));
            make.top.equalTo(self.mas_top).offset( kWidth(16+250)-columnBottomSpace - tipsHeight/2 - i*leftTipsHeight);
        }];
    }
    
    //scrollview
    [self addSubview:self.scrollview];
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(YView.mas_right);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(YView.mas_top);
        make.bottom.equalTo(self.mas_bottom).offset( -(kWidth(54)*heightScale) );
    }];
    
    //scrollview 填充数据
    for (int i=0 ;i<self.dataSource.count ;i++) {
        IncomeColumnExcellModel* model = self.dataSource[i];
        ColumnExcelItemView* view   = [[ColumnExcelItemView alloc] initWithFrame:CGRectMake(i*kWidth(100), 0, kWidth(100), kWidth(250))];
        view.viewColor              = [UIColor whiteColor];
        view.bottomTip              = [NSString stringWithFormat:@"%02ld/%02ld",self.month,model.day];
        view.maxMoney               = maxMoney;
        view.columNum               = 4;
        view.columWidth             = kWidth(5);
        view.columRedius            = kWidth(5)/2;
        view.arrayColor             = self.colorArray;
        view.arrayValue             = @[[NSNumber numberWithFloat:model.direct_money],[NSNumber numberWithFloat:model.agent_money],[NSNumber numberWithFloat:model.pos_money],[NSNumber numberWithFloat:model.return_money]];
        view.tipsWidth              = (kWidth(200)/view.columNum)/2;
        view.tipsHeight             = kWidth(16);
        view.tipsFontSize           = kWidth(9);
        view.tipsRadius             = kWidth(4);
        view.tipsBackgroundColor    = [UIColor whiteColor];
        view.isShow                 = NO;
        view.bottomSpace            = columnBottomSpace;
        view.clickBlcok = ^(BOOL isShow, ColumnExcelItemView *mSelf) {
            isShow      = !isShow;
            for (ColumnExcelItemView* item in self.itemArray) {
                if(item == mSelf){
                    item.isShow = isShow;
                }
                else{
                    item.isShow = NO;
                }
            }
        };
        [view setUI];
        [self.itemArray addObject:view];
        [self.scrollview addSubview:view];
    }
    
    self.scrollview.contentSize     = CGSizeMake(self.dataSource.count * kWidth(100), 0);
    
    //底部标签
    for(int i=0; i<self.colorArray.count; i++){
        [self createBottomTipsView:self.colorArray[i] andTips:self.bottomTipsArray[i] andIndex:i];
    }
}

-(UIView*)createBottomTipsView:(UIColor*)color andTips:(NSString*)tips andIndex:(NSInteger)index{
    UIView* backgroundView  = [UIView new];
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(index*(SCREEN_WIDTH/4));
        make.bottom.equalTo(self.mas_bottom).offset(-kWidth(10));
        make.width.mas_offset(SCREEN_WIDTH/4);
        make.height.mas_offset(kWidth(30));
    }];
    
    //内容
    UILabel* tipLB          = [LabelHelper CreateLabelByText:tips AndFont:kFONT(12) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentCenter];
    [backgroundView addSubview:tipLB];
    [tipLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backgroundView);
    }];
    
    //圆点
    UIView* pointV          = [UIView new];
    pointV.backgroundColor  = color;
    [pointV.layer setCornerRadius:kWidth(8)/2];
    pointV.layer.masksToBounds= YES;
    [backgroundView addSubview:pointV];
    [pointV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tipLB.mas_left).offset(-kWidth(5));
        make.centerY.equalTo(tipLB.mas_centerY);
        make.width.and.height.mas_offset(kWidth(8));
    }];
    
    return backgroundView;
}

-(CGFloat)getMaxMoney:(NSArray*)array{
    CGFloat money = 0.0f;
    for (IncomeColumnExcellModel* model in array) {
        //        money += itemMoney;
        if(money <= model.direct_money){
            money   = model.direct_money;
        }
        if(money <= model.agent_money){
            money   = model.agent_money;
        }
        if(money <= model.pos_money){
            money   = model.pos_money;
        }
        if(money <= model.return_money){
            money   = model.return_money;
        }
    }
    
    //    money   = money / array.count;              //每天平均收入
    
    if(0 >= money){                             //零收入
        self.maxMoneyStr   =   @"元";
        return 1;
    }
    else if(1 <= money && money < 10){
        self.maxMoneyStr   =   @"十元";
        return 10;
    }
    else if(10 <= money && money < 100){
        self.maxMoneyStr   =   @"百元";
        return 100;
    }
    else if(100 <= money && money < 100*10){
        self.maxMoneyStr   =   @"千元";
        return 100*10;
    }
    else if(100*10 <= money && money < 100*100){
        self.maxMoneyStr   =   @"万元";
        return 100*100;
    }
    else if(100*100 <= money && money < 100*100*10){
        self.maxMoneyStr   =   @"十万元";
        return 100*100*10;
    }
    else if(100*100*10 <= money && money < 100*100*100){
        self.maxMoneyStr   =   @"百万元";
        return 100*100*100;
    }
    else if(100*100*100 <= money && money < 100*100*100*10){
        self.maxMoneyStr   =   @"千万元";
        return 100*100*100*10;
    }
    else{
        self.maxMoneyStr   =   @"亿元";
        return 100*100*100*100;
    }
    
}

@end
