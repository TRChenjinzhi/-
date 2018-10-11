//
//  DIYScanViewController.h
//  LBXScanDemo
//
//  Created by lbxia on 2017/6/5.
//  Copyright © 2017年 lbx. All rights reserved.
//


#import <LBXScanViewController.h>

typedef void(^ScanResultBlock)(LBXScanResult* result);

@interface DIYScanViewController : LBXScanViewController

@property (nonatomic,copy)ScanResultBlock resultBlock;

@end
