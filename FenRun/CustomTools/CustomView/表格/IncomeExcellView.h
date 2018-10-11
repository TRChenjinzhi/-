//
//  IncomeExcellView.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/8.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger {
    month = 0,      //月
    day             //日
} IncomeExcelType;

typedef void(^IncomeExcelBaseMoney)(NSString* tips);

typedef void(^IncomeExcelBtnBlock)(CGFloat money,NSString* baseStr,UIButton* btn);

typedef void(^IncomeExcelScrollBegin)(void);

@interface IncomeExcellView : UIView

/**
 里面是一个 金额数组,给值就会刷新界面
 */
@property (nonatomic,strong)NSArray*        dataSource;

@property (nonatomic,copy)IncomeExcelBaseMoney   baseMoneyBlock;
@property (nonatomic,copy)IncomeExcelBtnBlock    btnBlock;
@property (nonatomic,copy)IncomeExcelScrollBegin scrollBeginBlock;

/**
 手动给frame 不过只要宽高
 */
@property (nonatomic,assign)CGRect      myFrame;

/**
 填充颜色
 */
@property (nonatomic,strong)UIColor*    fillColor;
/**
 折线颜色
 */
@property (nonatomic,strong)UIColor*    lineColor;

@property (nonatomic,assign)IncomeExcelType type;

@end
