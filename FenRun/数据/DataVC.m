//
//  DataVC.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/12.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "DataVC.h"

#import "ChartsPieView.h"

#define TotalDealHeight kHeight(160)
#define DealHeight      kHeight(332+40+50)
#define FenRunHeight    kHeight(340+40)

@interface DataVC ()

@property (nonatomic,strong)UIScrollView*   scrollview;

@property (nonatomic,assign)BOOL            isPos;
@property (nonatomic,strong)UIButton*       posBtn;
@property (nonatomic,strong)UIButton*       handerBtn;

//---------本月总交易额------------
@property (nonatomic,strong)UILabel*        totalDealTitle;
@property (nonatomic,strong)UILabel*        totalDealMoney;
@property (nonatomic,strong)UILabel*        totalDealShopMoney;
@property (nonatomic,strong)UILabel*        totalDealAgentMoney;

//---------交易类型汇总------------
@property (nonatomic,strong)ChartsPieView*  chartsPieV;

@end

@implementation DataVC

-(UIScrollView *)scrollview{
    if(!_scrollview){
        _scrollview = [BaseViewHelper getBaseScrollview];
        _scrollview.bounces = YES;
        _scrollview.frame   = CGRectMake(0, StatusBarHeight+NavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-NavigationBarHeight);
        self.automaticallyAdjustsScrollViewInsets   = NO;
    }
    return _scrollview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    IMP_BLOCK_SELF(DataVC)
    self.naviView.title = @"";
    [self.naviView.backBtn setHidden:YES];
    
    //navi 按钮设置
    [self naviViewBtn];
    
    //scrollview
    [self initScrollview];
    
    //本月总交易额
    UIView* totalDealV  = [self createTotalDealView];
    
    //交易类型汇总
    [self createDealTypeBySuperView:totalDealV];
}

-(UIView*)createDealTypeBySuperView:(UIView*)superView{
    UIView* backgroundV     = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:backgroundV];
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(DealHeight);
        make.top.equalTo(superView.mas_bottom).offset(kHeight(12));
    }];
    
    UIView* headerV         = [self createDealTypeHeader];
    [backgroundV addSubview:headerV];
    
    //饼状图
    ChartsPieView* chartsPieV= [ChartsPieView new];
    self.chartsPieV         = chartsPieV;
    [backgroundV addSubview:chartsPieV];
    [chartsPieV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(backgroundV);
        make.top.equalTo(headerV.mas_bottom);
        make.height.mas_offset(kHeight(332));
    }];
    [chartsPieV createUI];
    
    //交易类型详情
    UIView* footV           = [self createDealTypeFooter];
    [backgroundV addSubview:footV];
    
    return nil;
}

-(UIView*)createDealTypeFooter{
    UIView* backgroundV     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(50))];
    backgroundV.backgroundColor = [UIColor whiteColor];
    
    UILabel* tipsLB         = [LabelHelper CreateLabelByText:@"查看交易类型详情" AndFont:kFONT(12) AndTextColor:RGBA(87, 165, 251, 1) AndTextAligemt:NSTextAlignmentCenter];
    [backgroundV addSubview:tipsLB];
    [tipsLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backgroundV);
    }];
    
    UIImageView* nextImagV  = [UIImageView new];
    [nextImagV setImage:UIImageMake(@"ico_data_timer_open")];
    [backgroundV addSubview:nextImagV];
    [nextImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tipsLB.mas_right).offset(kWidth(8));
        make.centerY.equalTo(backgroundV.mas_centerY);
        make.width.mas_offset(kWidth(7));
        make.height.mas_offset(kHeight(11));
    }];
    
    UIView* topLine         = [UIView new];
    topLine.backgroundColor = LineColor;
    [backgroundV addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(backgroundV);
        make.height.mas_offset(LineHight);
    }];
    
    UIView* bottomLine         = [UIView new];
    bottomLine.backgroundColor = LineColor;
    [backgroundV addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(backgroundV);
        make.height.mas_offset(LineHight);
    }];
    
    [backgroundV addGestureRecognizer:[[UITapGestureRecognizer new] initWithActionBlock:^(id  _Nonnull sender) {
        NSLog(@"查看交易类型详情");
    }]];
    
    return backgroundV;
}

-(UIView*)createDealTypeHeader{
    UIView* headerV         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(40))];
    
    UIImageView* imagV      = [UIImageView new];
    [imagV setImage:UIImageMake(@"ico_data_list_type")];
    [headerV addSubview:imagV];
    [imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerV.mas_left).offset(kWidth(12));
        make.centerY.equalTo(headerV.mas_centerY);
    }];
    
    UILabel* tipsLB         = [LabelHelper CreateLabelByText:@"交易类型汇总" AndFont:kFONT(12) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    [headerV addSubview:tipsLB];
    [tipsLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imagV.mas_left).offset(kWidth(6));
        make.centerY.equalTo(headerV.mas_centerY);
    }];
    
    UIImageView* nextImagV  = [UIImageView new];
    [nextImagV setImage:UIImageMake(@"ico_data_timer_open")];
    [headerV addSubview:nextImagV];
    [nextImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerV.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(headerV.mas_centerY);
    }];
    
    UILabel* dateLB         = [LabelHelper CreateLabelByText:@"2018/9" AndFont:kFONT(14) AndTextColor:RGBA(128, 128, 128, 1) AndTextAligemt:NSTextAlignmentRight];
    [headerV addSubview:dateLB];
    [dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nextImagV.mas_left).offset(kWidth(8));
        make.centerY.equalTo(headerV.mas_centerY);
    }];
    
    UIView* line            = [UIView new];
    line.backgroundColor    = LineColor;
    [headerV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(headerV);
        make.height.mas_offset(LineHight);
    }];
    
    [headerV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        NSLog(@"交易类型汇总 弹出时间弹窗");
    }] ];
    
    return headerV;
}

-(UIView*)createTotalDealView{
    UIView* backgroundV     = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:backgroundV];
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.scrollview.mas_top);
        make.height.mas_offset(TotalDealHeight);
    }];
    
    NSString* title         = self.isPos ? @"大POS本月总交易额（元）" : @"手刷本月总交易额（元）";
    UILabel* titleLB        = [LabelHelper CreateLabelByText:title AndFont:kFONT(13) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentCenter];
    self.totalDealTitle     = titleLB;
    [backgroundV addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundV.mas_top).offset(kHeight(20));
        make.centerX.equalTo(backgroundV.mas_centerX);
    }];
    
    UILabel* totalMoneyLB   = [LabelHelper CreateLabelByText:@"0.00" AndFont:kFONT(32) AndTextColor:RGBA(255, 86, 76, 1) AndTextAligemt:NSTextAlignmentCenter];
    self.totalDealMoney     = totalMoneyLB;
    [backgroundV addSubview:totalMoneyLB];
    [totalMoneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLB.mas_bottom).offset(kHeight(16));
        make.centerX.equalTo(backgroundV.mas_centerX);
    }];
    
    UILabel* shopTips      = [LabelHelper CreateLabelByText:@"直营商户" AndFont:kFONT(12) AndTextColor:RGBA(128, 128, 128, 1) AndTextAligemt:NSTextAlignmentLeft];
    [backgroundV addSubview:shopTips];
    [shopTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(45));
        make.bottom.equalTo(backgroundV.mas_bottom).offset(-kWidth(43));
    }];
    
    UILabel* shopMoneyLB   = [LabelHelper CreateLabelByText:@"0.00" AndFont:kFONT(18) AndTextColor:RGBA(84, 166, 251, 1) AndTextAligemt:NSTextAlignmentLeft];
    self.totalDealShopMoney= shopMoneyLB;
    [backgroundV addSubview:shopMoneyLB];
    [shopMoneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(45));
        make.top.equalTo(shopTips.mas_bottom).offset(kWidth(8));
    }];
    
    UILabel* agentTips      = [LabelHelper CreateLabelByText:@"下级代理" AndFont:kFONT(12) AndTextColor:RGBA(128, 128, 128, 1) AndTextAligemt:NSTextAlignmentRight];
    [backgroundV addSubview:agentTips];
    [agentTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundV.mas_right).offset(kWidth(45));
        make.bottom.equalTo(backgroundV.mas_bottom).offset(-kWidth(43));
    }];
    
    UILabel* agentMoneyLB   = [LabelHelper CreateLabelByText:@"0.00" AndFont:kFONT(18) AndTextColor:RGBA(84, 166, 251, 1) AndTextAligemt:NSTextAlignmentRight];
    self.totalDealAgentMoney= agentMoneyLB;
    [backgroundV addSubview:agentMoneyLB];
    [agentMoneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundV.mas_right).offset(kWidth(45));
        make.top.equalTo(agentTips.mas_bottom).offset(kWidth(8));
    }];
    
    return backgroundV;
}

-(void)initScrollview{
    [self.view addSubview:self.scrollview];
    
}

-(void)naviViewBtn{
    IMP_BLOCK_SELF(DataVC)
    
    UIButton* returnMoneyBtn    = [UIButton new];
    [returnMoneyBtn setTitle:@"返现" forState:UIControlStateNormal];
    [returnMoneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [returnMoneyBtn.titleLabel setFont:kFONT(14)];
    [self.naviView addSubview:returnMoneyBtn];
    [returnMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.naviView.mas_left).offset(kWidth(12));
        make.centerY.equalTo(self.naviView.mas_centerY);
    }];
    
    [returnMoneyBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSLog(@"返现");
    }];
    
    UIButton* dealBtn           = [UIButton new];
    [dealBtn setTitle:@"交易排行" forState:UIControlStateNormal];
    [dealBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dealBtn.titleLabel setFont:kFONT(14)];
    [self.naviView addSubview:dealBtn];
    [dealBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.naviView.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(self.naviView.mas_centerY);
    }];
    
    [dealBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSLog(@"交易排行");
    }];
    
    UIButton* posBtn            = [UIButton new];
    self.posBtn                 = posBtn;
    [posBtn setBackgroundImage:UIImageMake(@"btn_template_pos_nor") forState:UIControlStateNormal];
    [posBtn setBackgroundImage:UIImageMake(@"btn_template_pos_dwn") forState:UIControlStateSelected];
    [self.naviView addSubview:posBtn];
    [posBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.naviView.mas_centerX);
        make.centerY.equalTo(self.naviView.mas_centerY);
    }];
    
    [posBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        UIButton* btn   = (UIButton*)sender;
        if(!btn.selected){
            btn.selected    = YES;
            block_self.handerBtn.selected   = NO;
        }
    }];
    
    UIButton* handerBtn             = [UIButton new];
    self.handerBtn                  = handerBtn;
    [handerBtn setBackgroundImage:UIImageMake(@"btn_template_hand_pos_nor") forState:UIControlStateNormal];
    [handerBtn setBackgroundImage:UIImageMake(@"btn_template_hand_pos_dwn") forState:UIControlStateSelected];
    [self.naviView addSubview:handerBtn];
    [handerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.naviView.mas_centerX);
        make.centerY.equalTo(self.naviView.mas_centerY);
    }];
    
    [handerBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        UIButton* btn   = (UIButton*)sender;
        if(!btn.selected){
            btn.selected    = YES;
            block_self.posBtn.selected   = NO;
        }
    }];
    
    if(!self.isPos){
        posBtn.selected     = YES;
        handerBtn.selected  = NO;
    }
    else{
        posBtn.selected     = NO;
        handerBtn.selected  = YES;
    }
}

@end
