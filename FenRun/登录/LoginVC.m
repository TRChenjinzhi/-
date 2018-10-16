//
//  LoginVC.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC () <QMUITextFieldDelegate>

@property (nonatomic,strong)QMUITextField* accountTF;
@property (nonatomic,strong)QMUITextField* passwordTF;

@end

@implementation LoginVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    if([LoginHelper getUserInfo]){
        [self LoginAction:[LoginHelper share].user_phone andPassword:[LoginHelper share].loginPasswrod];
    }
}

-(void)setUI{
    
    //背景上半 图片
    [self createBackgroundView];
    
    //登录视图
    [self createLoginView];
}

-(void)createLoginView{
    
    IMP_BLOCK_SELF(LoginVC)
    
    UIImageView* backgroundImagV    = [UIImageView new];
    backgroundImagV.userInteractionEnabled  = YES;
    [backgroundImagV setImage:UIImageMake(@"img_login_box_bg")];
    [self.view addSubview:backgroundImagV];
    [backgroundImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(kWidth(30));
        make.right.equalTo(self.view.mas_right).offset(-kWidth(30));
        make.height.mas_offset(kHeight(320));
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    //方框
    UIView* lineView    = [UIView new];
    [lineView.layer setBorderWidth:kWidth(1)];
    [lineView.layer setBorderColor:LineColor.CGColor];
    [lineView.layer setCornerRadius:kWidth(4)];
    [backgroundImagV addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundImagV.mas_left).offset(kWidth(17));
        make.right.equalTo(backgroundImagV.mas_right).offset(-kWidth(17));
        make.height.mas_offset(kHeight(100));
        make.top.equalTo(backgroundImagV.mas_top).offset(kHeight(52));
    }];
    
    //间隔横线
    UIView* line        = [UIView new];
    line.backgroundColor= LineColor;
    [lineView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(lineView);
        make.height.mas_offset(LineHight);
        make.centerY.equalTo(lineView.mas_centerY);
    }];
    
    //账号
    UIView* accountV    = [UIView new];
    [lineView addSubview:accountV];
    [accountV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(lineView);
        make.bottom.equalTo(line.mas_top);
    }];
    
    [self createAccountV:accountV];
    
    //密码
    UIView* passwordV    = [UIView new];
    [lineView addSubview:passwordV];
    [passwordV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(lineView);
        make.top.equalTo(line.mas_bottom);
    }];
    
    [self createPasswordV:passwordV];
    
    //忘记密码
    UIButton* forgetPasswordBtn = [UIButton new];
    [forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPasswordBtn setTitleColor:APPThemeBlue forState:UIControlStateNormal];
    [forgetPasswordBtn.titleLabel setFont:kFONT(12)];
    [backgroundImagV addSubview:forgetPasswordBtn];
    [forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineView.mas_right);
        make.top.equalTo(lineView.mas_bottom).offset(kHeight(12));
    }];
    [forgetPasswordBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        //跳转到 修改密码界面
        NSLog(@"忘记密码");
        LoginModefyPasswordVC* vc   = [LoginModefyPasswordVC new];
        [block_self.navigationController pushViewController:vc animated:YES];
    }];
    
    UIButton* loginBtn      = [UIButton new];
    [loginBtn setBackgroundImage:UIImageMake(@"btn_share_bg") forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn.layer setCornerRadius:kWidth(4)];
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSLog(@"登录");
        [block_self LoginAction:block_self.accountTF.text andPassword:block_self.passwordTF.text];
    }];
    [backgroundImagV addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundImagV.mas_left).offset(kWidth(17));
        make.right.equalTo(backgroundImagV.mas_right).offset(-kWidth(17));
        make.height.mas_offset(kHeight(66));
        make.top.equalTo(forgetPasswordBtn.mas_bottom).offset(kHeight(14));
    }];
}

-(void)createAccountV:(UIView*)accountV{
    UIImageView* imageV     = [UIImageView new];
    [imageV setImage:UIImageMake(@"ico_login_phone")];
    [accountV addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountV.mas_left).offset(kWidth(12));
        make.centerY.equalTo(accountV.mas_centerY);
        make.width.mas_offset(kWidth(20));
    }];
    
    QMUITextField* textF    = [QMUITextField new];
    self.accountTF          = textF;
    textF.placeholder       = @"手机号";
    textF.placeholderColor  = PlaceHolderColor;
    textF.font              = kFONT(14);
    textF.keyboardType      = UIKeyboardTypePhonePad;
    textF.returnKeyType     = UIReturnKeyDone;
    textF.delegate          = self;
    [accountV addSubview:textF];
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageV.mas_right);
        make.right.equalTo(accountV.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(accountV.mas_centerY);
        make.top.and.bottom.equalTo(accountV);
    }];
}

-(void)createPasswordV:(UIView*)passwordV{
    UIImageView* imageV     = [UIImageView new];
    [imageV setImage:UIImageMake(@"ico_login_password")];
    [passwordV addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordV.mas_left).offset(kWidth(12));
        make.centerY.equalTo(passwordV.mas_centerY);
        make.width.mas_offset(kWidth(20));
    }];
    
    QMUITextField* textF    = [QMUITextField new];
    self.passwordTF         = textF;
    textF.placeholder       = @"密码";
    textF.placeholderColor  = PlaceHolderColor;
    textF.font              = kFONT(14);
    textF.keyboardType      = UIKeyboardTypeDefault;
    textF.returnKeyType     = UIReturnKeyDone;
    textF.delegate          = self;
    [passwordV addSubview:textF];
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageV.mas_right);
        make.right.equalTo(passwordV.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(passwordV.mas_centerY);
        make.top.and.bottom.equalTo(passwordV);
    }];
}

-(void)createBackgroundView{
    UIImageView* backgroundImagV = [UIImageView new];
    [backgroundImagV setImage:UIImageMake(@"img_login_head_bg")];
    [self.view addSubview:backgroundImagV];
    [backgroundImagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.view);
        make.height.mas_offset(kHeight(230));
    }];
    
    UIImageView* appIcon    = [UIImageView new];
    [appIcon setImage:UIImageMake(@"login_desk_icon")];
    [backgroundImagV addSubview:appIcon];
    [appIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundImagV.mas_top).offset(kHeight(79));
        make.bottom.equalTo(backgroundImagV.mas_bottom).offset(-kHeight(92));
        make.width.and.height.mas_offset(kWidth(60));
        make.centerX.equalTo(backgroundImagV.mas_centerX);
    }];
    
    UILabel* appName        = [LabelHelper CreateLabelByText:[DeviceTools getAPPName] AndFont:kFONT(12) AndTextColor:[UIColor whiteColor] AndTextAligemt:NSTextAlignmentCenter];
    [backgroundImagV addSubview:appName];
    [appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(appIcon.mas_bottom).offset(kHeight(8));
        make.centerX.equalTo(appIcon.mas_centerX);
    }];
}


-(void)LoginAction:(NSString*)account andPassword:(NSString*)password{
    if([LoginRule checkPhoneNumber:account] &&
       [LoginRule passwordIsMatch:password])
    {
        
        NSLog(@"登录成功");
        
        [LoginHelper share].ID          = 18;
        [LoginHelper share].user_name   = @"北京韩惠国际";
        [LoginHelper share].user_phone  = @"15527747037";
        [LoginHelper share].sex         = 1;
        [LoginHelper share].logined     = YES;
        [LoginHelper share].loginPasswrod = @"123456abc";
        [LoginHelper share].address     = @"北京朝阳区";
        
        //保存账号信息
        [AppConfig saveUserInfo:[LoginHelper share]];
        
        TabBarViewController* vc    = [TabBarViewController new];
        [self presentViewController:vc animated:NO completion:nil];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark ----------QMUItextfield------------
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

@end
