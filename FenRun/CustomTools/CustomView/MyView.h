//
//  MyView.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/10.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UIView

/**
 左边一个label 右边一个label

 @param title title description
 @param titleColor titleColor description
 @param subTitle subTitle description
 @param subTitleColor subTitleColor description
 @param height height description
 @param superView superView description
 @param distance distance description
 @return return value description
 */
+(UIView*)CreateViewByTitle:(NSString*)title AndTitleColor:(UIColor*)titleColor AndSubTitle:(NSString*)subTitle AndSubTitleColor:(UIColor*)subTitleColor andHeight:(CGFloat)height andSuperView:(UIView*)superView andTopDistance:(CGFloat)distance;

/**
 一张照片 一个label

 @param title title description
 @param titleColor titleColor description
 @param font font description
 @param imagVName imagVName description
 @param height height description
 @param superView superView description
 @param distance distance description
 @return return value description
 */
+(UIView*)CreateViewByTitle:(NSString*)title AndTitleColor:(UIColor*)titleColor andFont:(UIFont*)font andImaviewName:(NSString*)imagVName andHeight:(CGFloat)height andSuperView:(UIView*)superView andTopDistance:(CGFloat)distance andTopView:(UIView*)topVIew;

@end
