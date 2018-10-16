//
//  MineVC.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "MineVC.h"
#import "MineTableviewDelegate.h"
#import "MineDetailInfoVC.h"
#import "MineWorkOrderVC.h"
#import "MineContactVC.h"
#import "LoginModefyPasswordVC.h"
#import "MineCardControlViewController.h"
#import "MineSuggestViewController.h"
#import "MineAboutMeViewController.h"

@interface MineVC ()

@property (nonatomic,strong)UIImageView*    mineIcon;
@property (nonatomic,strong)UILabel*        mineName;
@property (nonatomic,strong)UILabel*        minePhone;

@property (nonatomic,strong)UITableView*    tableview;
@property (nonatomic,strong)MineTableviewDelegate*    tvDelegate;

@end

@implementation MineVC

-(MineTableviewDelegate *)tvDelegate{
    if(!_tvDelegate){
        _tvDelegate = [MineTableviewDelegate new];
        _tvDelegate.dataSource = @[
                                   @[
                                       [MineModel getModelByTitle:@"银行卡管理" andImagName:@"ico_me_bank_card"],
                                       [MineModel getModelByTitle:@"工单记录查询" andImagName:@"ico_me_word_order"],
                                       [MineModel getModelByTitle:@"登录信息修改" andImagName:@"ico_me_login_edit"]
                                       ],
                                   @[
                                       [MineModel getModelByTitle:@"使用帮助" andImagName:@"ico_me_user_help"],
                                       [MineModel getModelByTitle:@"联系客服" andImagName:@"ico_me_customer_service"],
                                       [MineModel getModelByTitle:@"意见反馈" andImagName:@"ico_me_opinion"],
                                       [MineModel getModelByTitle:@"关于我们" andImagName:@"ico_me_about_us"]
                                       ]
                                   ];
        IMP_BLOCK_SELF(MineVC)
        _tvDelegate.returnBlock = ^(NSInteger section, NSInteger index) {
            [block_self goToVCBySection:section andIndex:index];
        };
    }
    return _tvDelegate;
}

-(UITableView *)tableview{
    if(!_tableview){
        _tableview              = [BaseViewHelper getBaseTableview];
        _tableview.delegate     = self.tvDelegate;
        _tableview.dataSource   = self.tvDelegate;
        [_tableview registerClass:[MineCell class] forCellReuseIdentifier:[MineCell className]];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    [self.naviView removeFromSuperview];
    
    //headerView
    UIView* headerView  = [self createHeaderView];
    
    //footView
    UIView* footView    = [self createFootView];
    
    //tableview
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(SCREEN_HEIGHT-TabBarHeight);
        make.top.equalTo(self.view.mas_top);
    }];
    
    self.tableview.tableHeaderView  = headerView;
    self.tableview.tableFooterView  = footView;
    
}

-(UIView*)createFootView{
    UIButton* exitBtn   = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(50))];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setBackgroundColor:[UIColor whiteColor]];
    [exitBtn.titleLabel setFont:kFONT(14)];
    [exitBtn setTitleColor:APPSubTextColor forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(ExitLogin) forControlEvents:UIControlEventTouchUpInside];
    
    return exitBtn;
}

-(UIView*)createHeaderView{
    UIView* headerView      = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeight(150))];
    
    //显示图
    UIImageView* mineInfoV  = [UIImageView new];
    [mineInfoV setImage:UIImageMake(@"img_me_head_bg")];
    [headerView addSubview:mineInfoV];
    [mineInfoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(mineInfoV);
        make.height.mas_offset(kHeight(150));
    }];
    
    UIImageView* icon       = [UIImageView new];
    self.mineIcon           = icon;
    [icon setImage:UIImageMake(@"img_me_head_image")];
    [icon.layer setCornerRadius:kHeight(48)/2];
    icon.layer.masksToBounds= YES;
    [mineInfoV addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mineInfoV.mas_left).offset(kWidth(29));
        make.top.equalTo(mineInfoV.mas_top).offset( StatusBarHeight + kHeight(30) );
        make.width.and.height.mas_offset(kHeight(48));
    }];
    
    UILabel* nameLB         = [LabelHelper CreateLabelByText:[LoginHelper share].user_name AndFont:kFONT(16) AndTextColor:[UIColor whiteColor] AndTextAligemt:NSTextAlignmentLeft];
    self.mineName           = nameLB;
    [mineInfoV addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(kWidth(11));
        make.top.equalTo(icon.mas_top).offset(kHeight(7));
    }];
    
    UILabel* phoneLB        = [LabelHelper CreateLabelByText:[LoginHelper share].user_phone AndFont:kFONT(12) AndTextColor:[UIColor whiteColor] AndTextAligemt:NSTextAlignmentLeft];
    self.minePhone          = phoneLB;
    [mineInfoV addSubview:phoneLB];
    [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLB.mas_left);
        make.top.equalTo(nameLB.mas_bottom).offset(kHeight(4));
    }];
    
    IMP_BLOCK_SELF(MineVC)
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        NSLog(@"进入 个人信息 详情信息");
        MineDetailInfoVC* vc    = [MineDetailInfoVC new];
        [block_self.navigationController pushViewController:vc animated:YES];
    }] ];
    
    
    return headerView;
}


-(void)goToVCBySection:(NSInteger)section andIndex:(NSInteger)index{
    NSLog(@"section:%ld,index:%ld",section,index);
    switch (index) {
        case 0:
        {
            if(section == 0){
                MineCardControlViewController* vc   = [MineCardControlViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                
            }
            break;
        }
        case 1:
        {
            if(section == 0){
                MineWorkOrderVC* vc = [MineWorkOrderVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                MIneContactVC* vc   = [MIneContactVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
        case 2:
        {
            if(section == 0){
                LoginModefyPasswordVC* vc   = [LoginModefyPasswordVC new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                MineSuggestViewController* vc   = [MineSuggestViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
        case 3:
        {
            if(section == 0){
                
            }
            else{
                MineAboutMeViewController* vc   = [MineAboutMeViewController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
            
        default:
            break;
    }
}

-(void)ExitLogin{
    NSLog(@"退出登录");
    if(self.loginOutBlock){
        self.loginOutBlock();
    }
}

@end
