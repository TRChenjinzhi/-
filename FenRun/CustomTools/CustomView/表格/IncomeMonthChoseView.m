//
//  IncomeMonthChoseView.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/24.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "IncomeMonthChoseView.h"

typedef void(^IncomeMonthChoseViewReturnBlock)(NSInteger month);
@interface IncomeMonthChoseCell : UITableViewCell

@property (nonatomic,strong)UILabel*    monthLB;
@property (nonatomic,strong)NSNumber*   monthStr;
@property (nonatomic,copy)IncomeMonthChoseViewReturnBlock   returnBlock;

@end

static NSString* identify   = @"IncomeMonthChoseCell";
@implementation IncomeMonthChoseCell

+(CGFloat)HieghtForCell{
    return kWidth(40);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    IncomeMonthChoseCell* cell   = [tableView dequeueReusableCellWithIdentifier:identify];
    if(!cell){
        cell    = [[IncomeMonthChoseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setUI];
    }
    return self;
}

-(void)setUI{
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = [UIColor whiteColor];
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self);
        make.height.mas_offset([IncomeMonthChoseCell HieghtForCell]);
    }];
    
    self.monthLB            = [LabelHelper CreateLabelByText:@"132" AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentCenter];
    [backgroundView addSubview:self.monthLB];
    [self.monthLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backgroundView);
    }];
    
    UIView* line            = [UIView new];
    line.backgroundColor    = LineColor;
    [backgroundView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(backgroundView);
        make.height.mas_offset(LineHight);
    }];
}

-(void)setMonthStr:(NSNumber *)monthStr{
    _monthStr   = monthStr;
    self.monthLB.text   = [NSString stringWithFormat:@"%ld 月",[monthStr integerValue]];
}

@end


@interface IncomeMonthChoseView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView*    tableview;
@property (nonatomic,strong)NSArray*        dataSource;

@end

@implementation IncomeMonthChoseView

-(NSArray *)dataSource{
    if(!_dataSource){
        _dataSource = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12];
    }
    return _dataSource;
}

-(UITableView *)tableview{
    if(!_tableview){
        _tableview  = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.bounces                          = NO;
        _tableview.showsVerticalScrollIndicator     = NO;
        _tableview.showsHorizontalScrollIndicator   = NO;
        _tableview.delegate                         = self;
        _tableview.dataSource                       = self;
        _tableview.estimatedSectionFooterHeight      = 1.1;
        _tableview.estimatedSectionHeaderHeight      = 1.1;
        _tableview.separatorStyle                    = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.backgroundColor    = RGBA(0, 0, 0, 0.4);
    
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = [UIColor whiteColor];
    [backgroundView.layer setCornerRadius:kWidth(12)];
    backgroundView.layer.masksToBounds  = YES;
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_offset(kWidth(280));
        make.height.mas_offset(kWidth(400));
    }];
    
    UIView* titleView       = [UIView new];
    titleView.backgroundColor   = [UIColor whiteColor];
    [backgroundView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(backgroundView);
        make.height.mas_offset(kWidth(40));
    }];
    
    UILabel* tipsLB         = [LabelHelper CreateLabelByText:@"选择月份" AndFont:KBFONT(18) AndTextColor:APPThemeBlue AndTextAligemt:NSTextAlignmentCenter];
    [titleView addSubview:tipsLB];
    [tipsLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(titleView);
    }];
    
    UIView* line            = [UIView new];
    line.backgroundColor    = LineColor;
    [titleView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(titleView);
        make.height.mas_offset(LineHight);
    }];
    
    [backgroundView addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(backgroundView);
        make.top.equalTo(titleView.mas_bottom);
    }];
}



#pragma mark ---------------tableview协议----------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IncomeMonthChoseCell* cell  = [IncomeMonthChoseCell cellWithTableView:tableView];
    cell.monthStr   = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.returnBlock){
        self.returnBlock(indexPath.row);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


@end


