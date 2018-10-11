//
//  LabelHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/4.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelHelper : NSObject

+(UILabel*)CreateLabelByText:(NSString*)text AndFont:(UIFont*)font AndTextColor:(UIColor*)textColor AndTextAligemt:(NSTextAlignment)aligment;
+(QMUILabel*)CreateQMUILabelByText:(NSString*)text AndFont:(UIFont*)font AndTextColor:(UIColor*)textColor AndTextAligemt:(NSTextAlignment)aligment;
+(CGFloat)GetLabelWidth:(UIFont*)font AndText:(NSString*)text;
+(CGFloat)GetLabelHight:(UIFont *)font AndText:(NSString *)text AndWidth:(CGFloat)width;
+(CGFloat)GetLabelHight:(UIFont *)font AndText:(NSString *)text AndWidth:(CGFloat)width andAttStr:(NSAttributedString*)attStr;

+(NSMutableAttributedString*)GetMutableAttributedSting_bold_font:(NSMutableAttributedString*)text AndIndex:(NSInteger)index AndCount:(NSInteger)count AndFontSize:(CGFloat)fontSize;
+(NSMutableAttributedString*)GetMutableAttributedSting_font:(NSMutableAttributedString*)text AndIndex:(NSInteger)index AndCount:(NSInteger)count AndFontSize:(CGFloat)fontSize;
+(NSMutableAttributedString*)GetMutableAttributedSting_color:(NSMutableAttributedString*)text AndIndex:(NSInteger)index AndCount:(NSInteger)count AndColor:(UIColor*)color;
+(NSMutableAttributedString*)GetMutableAttributedSting_lineSpaceing:(NSMutableAttributedString*)text AndSpaceing:(CGFloat)lineSpaceing;
+(NSMutableAttributedString*)GetMutableAttributedSting_wordSpaceing:(NSMutableAttributedString*)text AndSpaceing:(CGFloat)wordSpaceing;

/**
 首行缩进
 */
+(NSMutableAttributedString*)GetMutableAttributedSting_FirstLineSpace:(NSMutableAttributedString*)text andLineSpace:(CGFloat)lineSpace AndSpaceing:(CGFloat)FirstLineSpace;


@end
