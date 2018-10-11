//
//  IncomeMonthChoseView.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/24.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IncomeMonthChoseViewReturnBlock)(NSInteger month);

@interface IncomeMonthChoseView : UIView

@property (nonatomic,copy)IncomeMonthChoseViewReturnBlock   returnBlock;

@end
