//
//  LoginModefyPasswordVC.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "LoginModefyPasswordVC.h"

@interface LoginModefyPasswordVC () <QMUITextFieldDelegate>

@property (nonatomic,strong)QMUITextField*  phoneTF;
@property (nonatomic,strong)QMUITextField*  identifyTF;
@property (nonatomic,strong)QMUITextField*  passwordTF;
@property (nonatomic,strong)QMUITextField*  passwordAgainTF;

@property (nonatomic,assign)NSInteger       type;

@property (nonatomic,strong)IdentifyButton* identifyBtn;

@end


@implementation LoginModefyPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if(self.identifyBtn.isBegin){
        [self.identifyBtn Over];
    }
}

-(void)setUI{
    IMP_BLOCK_SELF(LoginModefyPasswordVC)
    
    self.naviView.title = @"密码重置";
    self.naviView.backBlock = ^{
        [block_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.type           = 0;
    UIView* phoneV      = [self createViewByTitle:@"手机号" andPlaceHolder:@"请输入" andSuperView:self.naviView andType:self.type];
    self.type           = 1;
    UIView* identifyV   = [self createViewByTitle:@"验证码" andPlaceHolder:@"请输入" andSuperView:phoneV andType:self.type];
    self.type           = 2;
    UIView* newPasswordV= [self createViewByTitle:@"新密码" andPlaceHolder:@"6-18位字母加数字组合" andSuperView:identifyV andType:self.type];
    self.type           = 3;
    UIView* passwordAgainV= [self createViewByTitle:@"重复密码" andPlaceHolder:@"6-18位字母加数字组合" andSuperView:newPasswordV andType:self.type];
    
    //添加验证码按钮
    IdentifyButton* identifyBtn = [IdentifyButton new];
    self.identifyBtn            = identifyBtn;
    [identifyBtn initData];
    identifyBtn.timeCount       = 60;
    [identifyV addSubview:identifyBtn];
    [identifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(identifyV.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(identifyV.mas_centerY);
    }];
    
    [identifyBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        IdentifyButton* tmp = (IdentifyButton*)sender;
        [tmp Begin];
        [AppConfig saveLoginModifByTimeByName:@"LoginModefyPasswordVC"];
    }];
    
    NSString* oldTime   = [AppConfig getLoginModifByTimeByName:@"LoginModefyPasswordVC"];
    NSString* nowTime   = [[TimeHelper share] getCurrentTime_seconds];
    if([oldTime floatValue] > 0){
        NSInteger nowInt= [nowTime integerValue];
        NSLog(@"nowTime:%@",nowTime);
        NSLog(@"oldTime:%@",oldTime);
        NSInteger oldInt= [oldTime integerValue];
        NSInteger cha   = nowInt - oldInt;
        NSLog(@"cha:%ld",cha);
        if( cha < 60 ){
            identifyBtn.timeCount   = 60-cha;
            [identifyBtn Begin];
        }
    }
    
    UIButton* makeSureBtn   = [UIButton new];
    [makeSureBtn setBackgroundImage:UIImageMake(@"btn_share_bg") forState:UIControlStateNormal];
    [makeSureBtn setTitle:@"重置" forState:UIControlStateNormal];
    [makeSureBtn.layer setCornerRadius:kHeight(4)];
    makeSureBtn.layer.masksToBounds = YES;
    [self.view addSubview:makeSureBtn];
    [makeSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(kWidth(48));
        make.right.equalTo(self.view.mas_right).offset(-kWidth(48));
        make.top.equalTo(passwordAgainV.mas_bottom).offset(kHeight(40));
    }];
    
    
    [makeSureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if([LoginRule checkPhoneNumber:block_self.phoneTF.text] &&
           [LoginRule checkIdentifyNumber:block_self.identifyTF.text] &&
           [LoginRule passwordIsMatch:block_self.passwordTF.text] &&
           [LoginRule passwordIsMatch:block_self.passwordAgainTF.text])
        {
            NSLog(@"重置成功");
        }
    }];
}

-(UIView*)createViewByTitle:(NSString*)title andPlaceHolder:(NSString*)placeHolder andSuperView:(UIView*)superView andType:(NSInteger)type{
    UIView* backgroundV = [UIView new];
    backgroundV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundV];
    [backgroundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(kHeight(50));
        make.top.equalTo(superView.mas_bottom);
    }];
    
    UILabel* titleLB    = [LabelHelper CreateLabelByText:title AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    [backgroundV addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
    }];
    
    QMUITextField* textF= [QMUITextField new];
    textF.placeholder       = placeHolder;
    textF.placeholderColor  = PlaceHolderColor;
    textF.font              = kFONT(14);
    textF.keyboardType      = UIKeyboardTypePhonePad;
    textF.returnKeyType     = UIReturnKeyDone;
    textF.delegate          = self;
    [backgroundV addSubview:textF];
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundV.mas_left).offset(kWidth(100));
        make.right.equalTo(backgroundV.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(backgroundV.mas_centerY);
        make.top.and.bottom.equalTo(backgroundV);
    }];
    
    switch (type) {
        case 0:
        {
            self.phoneTF    = textF;
            break;
        }
        case 1:
        {
            self.identifyTF = textF;
            break;
        }
        case 2:
        {
            self.passwordTF = textF;
            textF.keyboardType  = UIKeyboardTypeDefault;
            break;
        }
        case 3:
        {
            self.passwordAgainTF= textF;
            textF.keyboardType  = UIKeyboardTypeDefault;
            break;
        }
            
        default:
            break;
    }
    
    UIView* line        = [UIView new];
    line.backgroundColor= LineColor;
    [backgroundV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(backgroundV);
        make.height.mas_offset(LineHight);
    }];
    
    return backgroundV;
}


#pragma mark ----------QMUItextfield------------
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

@end
