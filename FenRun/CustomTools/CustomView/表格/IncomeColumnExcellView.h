//
//  IncomeColumnExcellView.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/15.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeColumnExcellModel.h"

@interface IncomeColumnExcellView : UIView

@property (nonatomic,strong)NSArray*            dataSource;
@property (nonatomic,strong)NSArray<UIColor*>*  colorArray;
@property (nonatomic,strong)NSArray<NSString*>* bottomTipsArray;

@property (nonatomic,assign)NSInteger month;

@property (nonatomic,copy)NSString* maxMoneyStr; //最大金额


-(void)setUI;

@end
