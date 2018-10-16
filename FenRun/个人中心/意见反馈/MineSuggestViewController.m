//
//  MineSuggestViewController.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/14.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MineSuggestViewController.h"

@interface MineSuggestViewController ()

@end

@implementation MineSuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    IMP_BLOCK_SELF(MineSuggestViewController)
    self.naviView.title = @"意见反馈";
    self.naviView.backBlock = ^{
        [block_self.navigationController popViewControllerAnimated:YES];
    };
    
    QMUITextView* textView  = [QMUITextView new];
    textView.placeholder    = @"请输入您的意见,不少于10个字符";
    textView.placeholderColor= PlaceHolderColor;
    textView.font           = kFONT(14);
    textView.textColor      = APPTextColor;
    [textView.layer setCornerRadius:kWidth(10)];
    textView.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviView.mas_bottom).offset(kWidth(12));
        make.left.equalTo(self.view.mas_left).offset(kWidth(12));
        make.right.equalTo(self.view.mas_right).offset(-kWidth(12));
        make.height.mas_offset(kWidth(150));
    }];
    
    UIButton* btn           = [UIButton new];
    [btn setBackgroundImage:UIImageMake(@"btn_share_bg") forState:UIControlStateNormal];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:kFONT(14)];
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
        if(textView.text.length >= 10){
            [QMUITips showLoading:@"正在提交.." inView:block_self.view];
//            [InternetHelper questionCommitBy:[LoginHelper share].ID andContent:textView.text AndSucess:^(NSDictionary *dic) {
//                [QMUITips hideAllTipsInView:block_self.view];
//                [QMUITips showSucceed:@"提交成功"];
//                [block_self.navigationController popViewControllerAnimated:YES];
//            } andFailed:^{
//                [QMUITips hideAllTipsInView:block_self.view];
//            }];
        }
        else{
            [QMUITips showInfo:@"不少于10个字符"];
        }
    }];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).offset(kWidth(20));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}


@end
