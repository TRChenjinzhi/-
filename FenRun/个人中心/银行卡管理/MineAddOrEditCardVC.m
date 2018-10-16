//
//  MineAddCardVC.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/27.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MineAddOrEditCardVC.h"
#import "UnionListTextFieldDelegate.h"

@interface MineAddOrEditCardVC ()

@property (nonatomic,strong)QMUITextField*      bankNameTextField;
@property (nonatomic,strong)QMUITextField*      nameTextField;
@property (nonatomic,strong)QMUITextField*      bankphoneTextField;
@property (nonatomic,strong)QMUITextField*      bankNumberTextField;
@property (nonatomic,strong)QMUITextField*      subBankNumberTextField;
@property (nonatomic,strong)QMUITextField*      subBankNameTextField;

/**
 0:开卡银行 1:持卡人姓名 2:预留银行手机号 3：银行卡号 4:分行联行号 5:开卡分行
 */
@property (nonatomic,assign)NSInteger           LBtype;

@property (nonatomic,strong)UnionListTextFieldDelegate*      textFieldDelegate;
@property (nonatomic,strong)UIButton*           defaultBtn;

@end

@implementation MineAddOrEditCardVC

-(UnionListTextFieldDelegate *)textFieldDelegate{
    if(!_textFieldDelegate){
        _textFieldDelegate  = [UnionListTextFieldDelegate new];
    }
    return _textFieldDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    IMP_BLOCK_SELF(MineAddOrEditCardVC)
    NSString* title     = nil;
    NSString* btnTitle  = nil;
    if(self.type == CardAdd){
        title   = @"添加银行卡";
        btnTitle= @"提交";
    }
    else if(self.type == CardEdit){
        title   = @"银行卡详情";
        btnTitle= @"删除本卡";
    }
    self.naviView.title = title;
    self.naviView.backBlock = ^{
        [block_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.LBtype           = 0;
    UIView* bankNameV   = [self createViewByTitle:@"开卡银行" andSuperView:nil andType:self.LBtype];
    self.LBtype           = 1;
    UIView* nameV       = [self createViewByTitle:@"持卡人姓名" andSuperView:bankNameV andType:self.LBtype];
    self.LBtype           = 2;
    UIView* bankPhone   = [self createViewByTitle:@"预留银行手机号" andSuperView:nameV andType:self.LBtype];
    self.LBtype           = 3;
    UIView* bankNumberV = [self createViewByTitle:@"银行卡号" andSuperView:bankPhone andType:self.LBtype];
    self.LBtype           = 4;
    UIView* subBankNumber= [self createViewByTitle:@"分行联行号" andSuperView:bankNumberV andType:self.LBtype];
    self.LBtype           = 5;
    UIView* subBankName = [self createViewByTitle:@"开卡分行" andSuperView:subBankNumber andType:self.LBtype];
    
    [self createDefaultViewByTitle:@"设为默认卡号" andSuperView:subBankName andTopDistance:kWidth(12)];
    
    if(self.type == CardEdit){
        self.bankNameTextField.text     = self.model.bank_name;
        self.nameTextField.text         = self.model.user_name;
        self.bankphoneTextField.text    = self.model.bank_phone;
        self.bankNumberTextField.text   = self.model.userBankNumber;
        self.subBankNumberTextField.text= self.model.bank_code;
        self.subBankNameTextField.text  = self.model.bank_open;
        
        [self.bankNameTextField setEnabled:NO];
        [self.nameTextField setEnabled:NO];
        [self.bankphoneTextField setEnabled:NO];
        [self.bankNumberTextField setEnabled:NO];
        [self.subBankNumberTextField setEnabled:NO];
        [self.subBankNameTextField setEnabled:NO];
        
        self.defaultBtn.selected        = self.model.isDefault;
    }
    
    UIButton* commitBtn = [UIButton new];
    [commitBtn setBackgroundImage:UIImageMake(@"img_share_head_bg") forState:UIControlStateNormal];
    [commitBtn setTitle:btnTitle forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn.layer setCornerRadius:kWidth(4)];
    commitBtn.layer.masksToBounds   = YES;
    [commitBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSLog(@"添加银行卡 提交");
        
        if(block_self.type == CardEdit){
            [QMUITips showLoading:@"删除中..." inView:block_self.view];
//            [InternetHelper CardDeleteBy:[LoginHelper share].ID andCardId:block_self.model.ID AndSucess:^(NSDictionary *dic) {
//                [QMUITips hideAllTipsInView:block_self.view];
//                [QMUITips showSucceed:@"删除成功"];
//                [block_self.navigationController popViewControllerAnimated:YES];
//                if(block_self.returnBlock){
//                    CardDetailModel* model  = [CardDetailModel new];
//                    model.user_name        = self.nameTextField.text;
//                    model.bank_name          = self.bankNameTextField.text;
//                    model.user_bank = self.subBankNumberTextField.text;
//                    model.bank_code        = self.bankNumberTextField.text;
//                    block_self.returnBlock(model);
//                }
//            } andFailed:^{
//                [QMUITips hideAllTipsInView:block_self.view];
//            }];
            return ;
        }
        
        if(
           [LoginRule checkCardNumber:block_self.bankNumberTextField.text] &&
           [LoginRule checkCardNumber:block_self.subBankNumberTextField.text] &&
           [LoginRule checkName:block_self.bankNameTextField.text] &&
           [LoginRule checkName:block_self.nameTextField.text] &&
           [LoginRule checkPhoneNumber:block_self.bankphoneTextField.text] &&
           [LoginRule checkName:block_self.subBankNameTextField.text]
           )
        {
            if(block_self.type == CardAdd){
                [QMUITips showLoading:@"提交中..." inView:block_self.view];
//                [InternetHelper AddCardBy:[LoginHelper share].ID
//                              andUsername:block_self.nameTextField.text
//                              andBankName:block_self.bankNameTextField.text
//                             adnBankPhone:block_self.bankphoneTextField.text
//                         andSubBankNumber:block_self.subBankNumberTextField.text
//                            andBankNumber:block_self.bankNumberTextField.text
//                           andSubBandName:block_self.subBankNameTextField.text
//                               andDefault:block_self.defaultBtn.selected
//                                AndSucess:^(NSDictionary *dic) {
//                                    [QMUITips hideAllTipsInView:block_self.view];
//                                    [QMUITips showSucceed:@"添加成功"];
//                                    [block_self.navigationController popViewControllerAnimated:YES];
//                                    if(block_self.returnBlock){
//                                        CardDetailModel* model  = [CardDetailModel new];
//                                        model.user_name        = self.nameTextField.text;
//                                        model.bank_name          = self.bankNameTextField.text;
//                                        model.user_bank = self.subBankNumberTextField.text;
//                                        model.bank_code        = self.bankNumberTextField.text;
//                                        block_self.returnBlock(model);
//                                    }
//                                }
//                                andFailed:^{
//                                    [QMUITips hideAllTipsInView:block_self.view];
//                                }];
            }
        }
        else{
            return ;
        }
        
    }];
    [self.view addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-kWidth(20));
        make.left.equalTo(self.view.mas_left).offset(kWidth(50));
        make.right.equalTo(self.view.mas_right).offset(-kWidth(50));
        make.height.mas_offset(kWidth(45));
    }];
}

-(UIView*)createViewByTitle:(NSString*)title andSuperView:(UIView*)superView andType:(NSInteger)type{
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(kWidth(50));
        if(superView){
            make.top.equalTo(superView.mas_bottom);
        }
        else{
            make.top.equalTo(self.naviView.mas_bottom);
        }
    }];
    
    UILabel* titleLB        = [LabelHelper CreateLabelByText:title AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    [backgroundView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView.mas_left).offset(kWidth(12));
        make.centerY.equalTo(backgroundView.mas_centerY);
    }];
    
    QMUITextField* textField= [QMUITextField new];
    textField.placeholder   = @"请输入";
    textField.placeholderColor= PlaceHolderColor;
    textField.font          = kFONT(14);
    textField.textColor     = APPTextColor;
    textField.delegate      = self.textFieldDelegate;
    textField.returnKeyType = UIReturnKeyDone;
    [backgroundView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView.mas_left).offset(kWidth(145));
        make.right.equalTo(backgroundView.mas_right).offset(-kWidth(12));
        make.height.equalTo(backgroundView.mas_height);
        make.centerY.equalTo(backgroundView.mas_centerY);
    }];
    
    if(type == 0){
        textField.keyboardType  = UIKeyboardTypeDefault;
        self.bankNameTextField  = textField;
    }
    if(type == 1){
        textField.keyboardType  = UIKeyboardTypeDefault;
        self.nameTextField      = textField;
    }
    if(type == 2){
        textField.keyboardType  = UIKeyboardTypePhonePad;
        self.bankphoneTextField = textField;
    }
    if(type == 3){
        textField.keyboardType  = UIKeyboardTypePhonePad;
        self.bankNumberTextField= textField;
    }
    if(type == 4){
        textField.keyboardType  = UIKeyboardTypePhonePad;
        self.subBankNumberTextField= textField;
    }
    if(type == 5){
        textField.keyboardType  = UIKeyboardTypeDefault;
        self.subBankNameTextField= textField;
    }
    
    UIView* line            = [UIView new];
    line.backgroundColor    = LineColor;
    [backgroundView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(backgroundView);
        make.height.mas_offset(LineHight);
    }];
    
    return backgroundView;
}


-(UIView*)createDefaultViewByTitle:(NSString*)title andSuperView:(UIView*)superView andTopDistance:(CGFloat)topDistance{
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(superView.mas_bottom).offset(kWidth(12));
        make.height.mas_offset(kWidth(50));
    }];
    
    UILabel* tips           = [LabelHelper CreateLabelByText:title AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentLeft];
    [backgroundView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView.mas_left).offset(kWidth(12));
        make.centerY.equalTo(backgroundView.mas_centerY);
    }];
    
    UIButton* defaultBtn    = [UIButton new];
    self.defaultBtn         = defaultBtn;
    [defaultBtn setImage:UIImageMake(@"btn_bank_card_set_nor") forState:UIControlStateNormal];
    [defaultBtn setImage:UIImageMake(@"btn_bank_card_set_dwn") forState:UIControlStateSelected];
    IMP_BLOCK_SELF(MineAddOrEditCardVC)
    [defaultBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if(block_self.type == CardAdd){
            UIButton* btn   = (UIButton*)sender;
            btn.selected    = !btn.selected;
        }
        else if(block_self.type == CardEdit){
            [QMUITips showLoading:@"默认设置中..." inView:block_self.view];
//            [InternetHelper DefaulteCardBy:[LoginHelper share].ID andCardId:block_self.model.ID AndSucess:^(NSDictionary *dic) {
//                [QMUITips hideAllTipsInView:block_self.view];
//                UIButton* btn   = (UIButton*)sender;
//                btn.selected    = !btn.selected;
//                if(block_self.returnBlock){
//                    CardDetailModel* model  = [CardDetailModel new];
//                    model.user_name         = self.nameTextField.text;
//                    model.bank_name         = self.bankNameTextField.text;
//                    model.bank_code         = self.subBankNumberTextField.text;
//                    model.user_bank         = self.bankNumberTextField.text;
//                    [LoginHelper share].defaultCard = model;
//                    block_self.returnBlock(model);
//                }
//            } andFailed:^{
//                [QMUITips hideAllTipsInView:block_self.view];
//            }];
        }
    }];
    [backgroundView addSubview:defaultBtn];
    [defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundView.mas_right).offset(-kWidth(12));
        make.centerY.equalTo(backgroundView.mas_centerY);
    }];
    
    return backgroundView;
}

@end
