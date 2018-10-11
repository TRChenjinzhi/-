//
//  MyWindow.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/20.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWindow : NSObject

/**
 简单的 确定 或 取消 对话框
 */
+(void)showNormalWindByTitle:(NSString*)title AndYes:(void(^)(void))sucess AndNo:(void(^)(void))failed;


/**
 强制更新对话框
 */
+(void)showForceUpdateByTitle:(NSString*)title AndYes:(void(^)(void))sucess;


/**
 数量对话框 可以加减，可以手动输入
 */
+(void)showCountWidownByCount:(NSInteger)count AndAdd:(void(^)(void))add AndDelete:(void(^)(void))deleter AndYes:(void(^)(NSInteger sureCount))sucess AndNo:(void(^)(NSInteger cacelCount))failed;

/**
 提示实名认证-未认证
 */
+(void)showRealNameWindownForNOSucess:(void(^)(void))sucess AndFailed:(void(^)(void))failed;

/**
 提示实名认证-审核中
 */
+(void)showRealNameWindownForDoing;


/**
 弹出 从下到上 的列表弹窗
 */
+(void)showSheetWindownByTitle:(NSString*)title andBottonTitleArray:(NSArray*)btnTitleArray andSuper:(UIViewController*)weakSelf Sucess:(void(^)(NSString* title))sucess AndFailed:(void(^)(void))failed;


/**
 带输入框的 的弹窗
 */
+(void)showTextFiledWidownByTitle:(NSString*)title andKeyBordType:(UIKeyboardType)keyboardType Sucess:(void(^)(NSString* title))sucess AndFailed:(void(^)(void))failed;

@end
