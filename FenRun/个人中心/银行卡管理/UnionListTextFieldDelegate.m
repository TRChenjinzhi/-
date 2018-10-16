//
//  UnionListTextFieldDelegate.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/10.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "UnionListTextFieldDelegate.h"

@implementation UnionListTextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(self.textFieldBlock){
        NSString* text  = [textField.text stringByReplacingCharactersInRange:range withString:string];
        self.textFieldBlock(text);
    }
    
    NSString* text  = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if(text.length > TextFieldLength){
        [QMUITips showError:[NSString stringWithFormat:@"最高输入 %ld 位",(long)TextFieldLength]];
        return NO;
    }
    else{
        return YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
