//
//  MyBarCodeHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/25.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBarCodeHelper : NSObject

+(void)getBarCodeStringFromCameraByVC:(UIViewController*)weakSelf Sucess:(void(^)(NSString* barCodeString))sucess;
+ (LBXScanViewStyle*)notSquare;

@end
