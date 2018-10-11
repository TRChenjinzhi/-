//
//  ColumnExcelItemView.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/15.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColumnExcelItemView;
typedef void(^ColumnExcelItemViewClickBlock)(BOOL isShow,ColumnExcelItemView* mSelf);

@interface ColumnExcelItemView : UIView

@property (nonatomic,copy)ColumnExcelItemViewClickBlock clickBlcok;

#pragma mark ------------背景-------------------
/**
 背景颜色
 */
@property (nonatomic,strong)UIColor*   viewColor;
/**
 view底部标签
 */
@property (nonatomic,copy)NSString*    bottomTip;
/**
 view底部高度（指圆柱底部到view的底部高度）
 */
@property (nonatomic,assign)CGFloat    bottomSpace;

/**
 最高金额
 */
@property (nonatomic,assign)CGFloat     maxMoney;

#pragma mark ------------圆柱-------------------
/**
 圆柱数量
 */
@property (nonatomic,assign)NSInteger   columNum;
/**
 圆柱宽度
 */
@property (nonatomic,assign)CGFloat     columWidth;

/**
 圆柱上部分 圆角
 */
@property (nonatomic,assign)CGFloat     columRedius;

/**
 圆柱值的数组
 */
@property (nonatomic,strong)NSArray*    arrayValue;
/**
 圆柱值的颜色
 */
@property (nonatomic,strong)NSArray<UIColor*>*    arrayColor;


#pragma mark ------------标签-------------------
/**
 圆柱标签width
 */
@property (nonatomic,assign)CGFloat     tipsWidth;
/**
 圆柱标签height
 */
@property (nonatomic,assign)CGFloat     tipsHeight;
/**
 圆柱标签字体
 */
@property (nonatomic,assign)CGFloat     tipsFontSize;

/**
 圆柱标签圆角
 */
@property (nonatomic,assign)CGFloat     tipsRadius;

/**
 圆柱标签背景颜色
 */
@property (nonatomic,strong)UIColor*    tipsBackgroundColor;

/**
 是否显示标签
 */
@property (nonatomic,assign)BOOL        isShow;

/**
 布置UI
 */
-(void)setUI;

-(void)clearAll;

@end
