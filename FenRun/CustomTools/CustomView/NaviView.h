//
//  NaviView.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/6.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ NaciViewBackBlock)(void);

@interface NaviView : UIView

@property (nonatomic,copy)NSString*         title;
@property (nonatomic,strong)UILabel*        titleLB;
@property (nonatomic,copy)NaciViewBackBlock backBlock;
@property (nonatomic,assign)BOOL            isHideBtn;
@property (nonatomic,strong)UIView*         underLine;
@property (nonatomic,strong)UIImageView*    backgroundImav;
@property (nonatomic,strong)UIButton*       backBtn;

@end
