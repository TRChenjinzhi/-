//
//  MyBarCodeHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/25.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MyBarCodeHelper.h"

#import <objc/message.h>

#import "LBXScanViewStyle.h"
#import "DIYScanViewController.h"

@implementation MyBarCodeHelper

+(void)getBarCodeStringFromCameraByVC:(UIViewController*)weakSelf Sucess:(void(^)(NSString* result))sucess{
    DIYScanViewController *vc = [DIYScanViewController new];
    vc.style = [MyBarCodeHelper notSquare];
    vc.isOpenInterestRect = YES;
    vc.libraryType = SLT_ZXing;
    vc.scanCodeType = SCT_BarEAN13;
    
    vc.resultBlock = ^(LBXScanResult*result) {
        sucess(result.strScanned);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [weakSelf.navigationController pushViewController:vc animated:YES];
}

+ (LBXScanViewStyle*)notSquare
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 4;
    style.photoframeAngleW = 28;
    style.photoframeAngleH = 16;
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_LineStill;
    style.animationImage = [Color_Image_Helper createImageWithColor:[UIColor redColor]];
    //非正方形
    //设置矩形宽高比
    style.whRatio = 4.3/2.18;
    //离左边和右边距离
    style.xScanRetangleOffset = 30;
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    return style;
}

@end
