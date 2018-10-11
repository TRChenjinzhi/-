//
//  MyWindow.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/20.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MyWindow.h"

@implementation MyWindow

+(void)showNormalWindByTitle:(NSString *)title AndYes:(void (^)(void))sucess AndNo:(void (^)(void))failed{
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = RGBA(0, 0, 0, 0.4);
    [theWindow addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(theWindow);
    }];
    
    UIView* centerView      = [UIView new];
    centerView.backgroundColor  = [UIColor whiteColor];
    [centerView.layer setCornerRadius:kWidth(12)];
    centerView.layer.masksToBounds= YES;
    [backgroundView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kWidth(280));
        make.height.mas_offset(kWidth(145));
        make.center.equalTo(backgroundView);
    }];
    
    
    //输入层
    UIView* countView       = [UIView new];
    [centerView addSubview:countView];
    [countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(centerView);
        make.right.equalTo(centerView.mas_right);
        make.height.mas_offset(kWidth(100));
    }];
    
    
    UILabel* tips                   = [LabelHelper CreateLabelByText:title AndFont:kFONT(18) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentCenter];
    tips.numberOfLines              = 0;
    [countView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countView.mas_centerY);
        make.centerX.equalTo(countView.mas_centerX);
    }];
    
    UIView* countLine               = [UIView new];
    countLine.backgroundColor       = LineColor;
    [countView addSubview:countLine];
    [countLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(countView);
        make.height.mas_offset(LineHight);
    }];
    
    
    //按钮层
    UIView* btnView                 = [UIView new];
    btnView.backgroundColor         = [UIColor whiteColor];
    [centerView addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(centerView);
        make.height.mas_offset(kWidth(45));
    }];
    
    UIView* lineMidBtns             = [UIView new];
    lineMidBtns.backgroundColor     = LineColor;
    [btnView addSubview:lineMidBtns];
    [lineMidBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnView.mas_top);
        make.width.mas_offset(1);
        make.height.equalTo(btnView.mas_height);
        make.centerX.equalTo(btnView.mas_centerX);
    }];
    
    UIButton* cancelBtn             = [UIButton new];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:APPSubTextColor forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:kFONT(16)];
    [cancelBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        failed();
        [backgroundView removeFromSuperview];
    }];
    [btnView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(btnView);
        make.right.equalTo(lineMidBtns.mas_left);
    }];
    
    UIButton* sureBtn             = [UIButton new];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:APPThemeBlue forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:kFONT(16)];
    [sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        sucess();
        [backgroundView removeFromSuperview];
    }];
    [btnView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(btnView);
        make.left.equalTo(lineMidBtns.mas_right);
    }];
    
    [btnView bringSubviewToFront:lineMidBtns];
}


/**
 强制更新对话框
 */
+(void)showForceUpdateByTitle:(NSString*)title AndYes:(void(^)(void))sucess
{
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = RGBA(0, 0, 0, 0.4);
    [theWindow addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(theWindow);
    }];
    
    UIView* centerView      = [UIView new];
    centerView.backgroundColor  = [UIColor whiteColor];
    [centerView.layer setCornerRadius:kWidth(12)];
    centerView.layer.masksToBounds= YES;
    [backgroundView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kWidth(280));
        make.height.mas_offset(kWidth(145));
        make.center.equalTo(backgroundView);
    }];
    
    
    //输入层
    UIView* countView       = [UIView new];
    [centerView addSubview:countView];
    [countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(centerView);
        make.right.equalTo(centerView.mas_right);
        make.height.mas_offset(kWidth(100));
    }];
    
    
    UILabel* tips                   = [LabelHelper CreateLabelByText:title AndFont:kFONT(18) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentCenter];
    tips.numberOfLines              = 0;
    [countView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countView.mas_centerY);
        make.centerX.equalTo(countView.mas_centerX);
    }];
    
    UIView* countLine               = [UIView new];
    countLine.backgroundColor       = LineColor;
    [countView addSubview:countLine];
    [countLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(countView);
        make.height.mas_offset(LineHight);
    }];
    
    
    //按钮层
    UIView* btnView                 = [UIView new];
    btnView.backgroundColor         = [UIColor whiteColor];
    [centerView addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(centerView);
        make.height.mas_offset(kWidth(45));
    }];
    
    UIButton* sureBtn             = [UIButton new];
    [sureBtn setTitle:@"去更新" forState:UIControlStateNormal];
    [sureBtn setTitleColor:APPThemeBlue forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:kFONT(16)];
    [sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        sucess();
//        [backgroundView removeFromSuperview];
    }];
    [btnView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(btnView);
        make.left.equalTo(btnView.mas_left);
    }];
}


/**
 数量对话框 可以加减，可以手动输入
 */
+(void)showCountWidownByCount:(NSInteger)count AndAdd:(void(^)(void))add AndDelete:(void(^)(void))deleter AndYes:(void(^)(NSInteger sureCount))sucess AndNo:(void(^)(NSInteger cacelCount))failed{
    
    __block NSInteger cnt = count;
    __block QMUITextField* textfield = nil;
    
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = RGBA(0, 0, 0, 0.4);
    [theWindow addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(theWindow);
    }];
    
    UIView* centerView      = [UIView new];
    centerView.backgroundColor  = [UIColor whiteColor];
    [centerView.layer setCornerRadius:kWidth(12)];
    centerView.layer.masksToBounds= YES;
    [backgroundView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kWidth(280));
        make.height.mas_offset(kWidth(145));
        make.center.equalTo(backgroundView);
    }];
    
    
    //输入层
    UIView* countView       = [UIView new];
    [centerView addSubview:countView];
    [countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(centerView);
        make.right.equalTo(centerView.mas_right);
        make.height.mas_offset(kWidth(100));
    }];
    
    UILabel* tips                   = [LabelHelper CreateLabelByText:@"商品数量" AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentCenter];
    [countView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countView.mas_top).offset(kWidth(12));
        make.centerX.equalTo(countView.mas_centerX);
    }];
    
    QMUITextField* countTextfield = [QMUITextField new];
    textfield                     = countTextfield;
    countTextfield.placeholder    = @"请输入商品数量";
    countTextfield.placeholderColor= PlaceHolderColor;
    countTextfield.text           = [NSString stringWithFormat:@"%ld",count];
    countTextfield.textColor      = APPTextColor;
    countTextfield.font           = kFONT(14);
    countTextfield.textInsets     = UIEdgeInsetsMake(0, 10, 0, 0);
    countTextfield.keyboardType   = UIKeyboardTypePhonePad;
    [countTextfield.layer setBorderWidth:kWidth(1)];
    [countTextfield.layer setBorderColor:LineColor.CGColor];
    [countTextfield.layer setCornerRadius:kWidth(6)];
    [countView addSubview:countTextfield];
    [countTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countView.mas_left).offset(kWidth(48));
        make.right.equalTo(countView.mas_right).offset(-kWidth(48));
        make.top.equalTo(tips.mas_bottom).offset(kWidth(12));
        make.height.mas_offset(kWidth(45));
    }];
    
    UIView* countLine               = [UIView new];
    countLine.backgroundColor       = LineColor;
    [countView addSubview:countLine];
    [countLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(countView);
        make.height.mas_offset(LineHight);
    }];
    
    
    //按钮层
    UIView* btnView                 = [UIView new];
    btnView.backgroundColor         = [UIColor whiteColor];
    [centerView addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(centerView);
        make.height.mas_offset(kWidth(45));
    }];
    
    UIView* lineMidBtns             = [UIView new];
    lineMidBtns.backgroundColor     = LineColor;
    [btnView addSubview:lineMidBtns];
    [lineMidBtns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnView.mas_top);
        make.width.mas_offset(1);
        make.height.equalTo(btnView.mas_height);
        make.centerX.equalTo(btnView.mas_centerX);
    }];
    
    UIButton* cancelBtn             = [UIButton new];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:APPSubTextColor forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:kFONT(16)];
    [cancelBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        failed(cnt);
        [backgroundView removeFromSuperview];
    }];
    [btnView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(btnView);
        make.right.equalTo(lineMidBtns.mas_left);
    }];
    
    UIButton* sureBtn             = [UIButton new];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:APPThemeBlue forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:kFONT(16)];
    [sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if([LoginRule checkNumber:textfield.text]){
            NSInteger machineCount  = [textfield.text integerValue];
            if(machineCount < MachineMinCount){
                [QMUITips showInfo:[NSString stringWithFormat:@"最低 %ld 件",(long)MachineMinCount]];
                return ;
            }
            if(machineCount > MachineMaxCount){
                [QMUITips showInfo:[NSString stringWithFormat:@"最高 %ld 件",(long)MachineMaxCount]];
                return ;
            }
            sucess(machineCount);
            [backgroundView removeFromSuperview];
        }
        else{
            [QMUITips showInfo:@"请输入纯数字"];
        }
    }];
    [btnView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.bottom.equalTo(btnView);
        make.left.equalTo(lineMidBtns.mas_right);
    }];
    
    [btnView bringSubviewToFront:lineMidBtns];
}


+(void)showRealNameWindownForNOSucess:(void (^)(void))sucess AndFailed:(void (^)(void))failed{
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = RGBA(0, 0, 0, 0.6);
    
    [theWindow addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(theWindow);
    }];
    
    UIView* centerView              = [UIView new];
    centerView.backgroundColor      = [UIColor whiteColor];
    [centerView.layer setCornerRadius:kWidth(12)];
    centerView.layer.masksToBounds  = YES;
    [backgroundView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kWidth(280));
        make.height.mas_offset(kWidth(320));
        make.center.equalTo(backgroundView);
    }];
    
    UIImageView* imagV              = [UIImageView new];
    [imagV setImage:UIImageMake(@"img_name_tips_window")];
    [centerView addSubview:imagV];
    [imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.mas_top);
        make.centerX.equalTo(centerView.mas_centerX);
    }];
    
    UILabel* tips                   = [LabelHelper CreateLabelByText:@"您需要进行实名认证" AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentCenter];
    [centerView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imagV.mas_bottom);
        make.centerX.equalTo(centerView.mas_centerX);
    }];
    
    UIButton* goToRealNameBtn       = [UIButton new];
    [goToRealNameBtn setBackgroundImage:UIImageMake(@"btn_name_tips_window_bg") forState:UIControlStateNormal];
    [goToRealNameBtn setTitle:@"立即认证" forState:UIControlStateNormal];
    [goToRealNameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goToRealNameBtn.titleLabel setFont:kFONT(14)];
    [goToRealNameBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [backgroundView removeFromSuperview];
        sucess();
    }];
    [centerView addSubview:goToRealNameBtn];
    [goToRealNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips.mas_bottom).offset(kWidth(20));
        make.centerX.equalTo(centerView.mas_centerX);
    }];
    
    
    UIButton* cancelBtn             = [UIButton new];
    [cancelBtn setImage:UIImageMake(@"btn_name_tips_window_close") forState:UIControlStateNormal];
    [cancelBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [backgroundView removeFromSuperview];
        failed();
    }];
    [backgroundView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.mas_bottom).offset(kWidth(32));
        make.centerX.equalTo(backgroundView.mas_centerX);
    }];
}


/**
 提示实名认证-审核中
 */
+(void)showRealNameWindownForDoing{
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = RGBA(0, 0, 0, 0.6);
    
    [theWindow addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(theWindow);
    }];
    
    UIView* centerView              = [UIView new];
    centerView.backgroundColor      = [UIColor whiteColor];
    [centerView.layer setCornerRadius:kWidth(12)];
    centerView.layer.masksToBounds  = YES;
    [backgroundView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(kWidth(280));
        make.height.mas_offset(kWidth(320));
        make.center.equalTo(backgroundView);
    }];
    
    UIImageView* imagV              = [UIImageView new];
    [imagV setImage:UIImageMake(@"img_name_tips_window")];
    [centerView addSubview:imagV];
    [imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.mas_top);
        make.centerX.equalTo(centerView.mas_centerX);
    }];
    
    UILabel* tips                   = [LabelHelper CreateLabelByText:@"您提交的认证资料正在审核" AndFont:kFONT(14) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentCenter];
    [centerView addSubview:tips];
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imagV.mas_bottom);
        make.centerX.equalTo(centerView.mas_centerX);
    }];
    
    UIButton* goToRealNameBtn       = [UIButton new];
    [goToRealNameBtn setBackgroundImage:UIImageMake(@"btn_name_tips_window_bg") forState:UIControlStateNormal];
    [goToRealNameBtn setTitle:@"我知道了" forState:UIControlStateNormal];
    [goToRealNameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [goToRealNameBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [backgroundView removeFromSuperview];
    }];
    [centerView addSubview:goToRealNameBtn];
    [goToRealNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips.mas_bottom).offset(kWidth(20));
        make.centerX.equalTo(centerView.mas_centerX);
    }];
    
    
    UIButton* cancelBtn             = [UIButton new];
    [cancelBtn setImage:UIImageMake(@"btn_name_tips_window_close") forState:UIControlStateNormal];
    [cancelBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [backgroundView removeFromSuperview];
    }];
    [backgroundView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView.mas_bottom).offset(kWidth(32));
        make.centerX.equalTo(backgroundView.mas_centerX);
    }];
}


+(void)showSheetWindownByTitle:(NSString*)title andBottonTitleArray:(NSArray*)btnTitleArray andSuper:(UIViewController*)weakSelf Sucess:(void(^)(NSString* title))sucess AndFailed:(void(^)(void))failed
{
    //创建一个UIActionSheet，其中destructiveButton会红色显示，可以用在一些重要的选项
    UIAlertController* alertVC  = [UIAlertController alertControllerWithTitle:@"请选择" message:title preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSString* btnTitle in btnTitleArray) {
        UIAlertAction* alertAction  = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"%@",action.title);
            sucess(action.title);
        }];
        
        [alertVC addAction:alertAction];
    }
    
    UIAlertAction* alertAction  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"%@",action.title);
        failed();
    }];
    
    [alertVC addAction:alertAction];
    
    [weakSelf presentViewController:alertVC animated:YES completion:nil];
}

+(void)showTextFiledWidownByTitle:(NSString*)title andKeyBordType:(UIKeyboardType)keyboardType Sucess:(void(^)(NSString* title))sucess AndFailed:(void(^)(void))failed{
    QMUIDialogTextFieldViewController *dialogViewController = [[QMUIDialogTextFieldViewController alloc] init];
    dialogViewController.title = title;
    __block QMUITextField* textFieldCopy = nil;
    [dialogViewController addTextFieldWithTitle:nil configurationHandler:^(QMUILabel *titleLabel, QMUITextField *textField, CALayer *separatorLayer) {
        textField.keyboardType  = keyboardType;
        textField.placeholder   = title;
        textField.maximumTextLength = TextFieldLength;
        textFieldCopy           = textField;
    }];
    dialogViewController.enablesSubmitButtonAutomatically = YES;// 自动根据输入框的内容是否为空来控制 submitButton.enabled 状态。这个属性默认就是 YES，这里为写出来只是为了演示
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *dialogViewController) {
        [dialogViewController hide];
        sucess(textFieldCopy.text);
        
    }];
    [dialogViewController show];
}

@end
