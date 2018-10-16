//
//  UnionListTextFieldDelegate.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/10.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TextFieldBlock)(NSString* text);

@interface UnionListTextFieldDelegate : NSObject <QMUITextFieldDelegate>

@property (nonatomic,copy)TextFieldBlock  textFieldBlock;
@property (nonatomic,weak)id                weakSelf;

@end
