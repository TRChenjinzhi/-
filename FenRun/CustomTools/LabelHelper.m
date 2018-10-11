//
//  LabelHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/4.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "LabelHelper.h"

@implementation LabelHelper

+(UILabel*)CreateLabelByText:(NSString*)text AndFont:(UIFont*)font AndTextColor:(UIColor*)textColor AndTextAligemt:(NSTextAlignment)aligment{
    UILabel* label = [UILabel new];
    label.text          = text;
    label.textColor     = textColor;
    label.textAlignment = aligment;
    label.font          = font;
    return label;
}

+(QMUILabel*)CreateQMUILabelByText:(NSString*)text AndFont:(UIFont*)font AndTextColor:(UIColor*)textColor AndTextAligemt:(NSTextAlignment)aligment{
    QMUILabel* label = [QMUILabel new];
    label.text          = text;
    label.textColor     = textColor;
    label.textAlignment = aligment;
    label.font          = font;
    return label;
}

+(CGFloat)GetLabelWidth:(UIFont *)font AndText:(NSString *)text{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = text;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

+(CGFloat)GetLabelHight:(UIFont *)font AndText:(NSString *)text AndWidth:(CGFloat)width{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    
    label.text = text;
    label.font = font;
    label.numberOfLines = 0;
    
    [label sizeToFit];
    return label.frame.size.height;
}

+(CGFloat)GetLabelHight:(UIFont *)font AndText:(NSString *)text AndWidth:(CGFloat)width andAttStr:(NSAttributedString*)attStr{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    
    label.attributedText    = attStr;
    label.font = font;
    label.numberOfLines = 0;
    
    [label sizeToFit];
    return label.frame.size.height;
}

+(NSMutableAttributedString*)GetMutableAttributedSting_bold_font:(NSMutableAttributedString*)text AndIndex:(NSInteger)index AndCount:(NSInteger)count AndFontSize:(CGFloat)fontSize{
    
    [text addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontSize] range:NSMakeRange(index,count)];
    return text;
}

+(NSMutableAttributedString*)GetMutableAttributedSting_font:(NSMutableAttributedString*)text AndIndex:(NSInteger)index AndCount:(NSInteger)count AndFontSize:(CGFloat)fontSize{
    
    [text addAttribute:NSFontAttributeName value:kFONT(fontSize) range:NSMakeRange(index,count)];
    return text;
}

+(NSMutableAttributedString*)GetMutableAttributedSting_color:(NSMutableAttributedString*)text AndIndex:(NSInteger)index AndCount:(NSInteger)count AndColor:(UIColor*)color{
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(index,count)];
    return text;
}

+(NSMutableAttributedString*)GetMutableAttributedSting_lineSpaceing:(NSMutableAttributedString*)text AndSpaceing:(CGFloat)lineSpaceing{
    //设置缩进、行距
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpaceing;//行距
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    return text;
}

+(NSMutableAttributedString*)GetMutableAttributedSting_wordSpaceing:(NSMutableAttributedString*)text AndSpaceing:(CGFloat)wordSpaceing{
    NSNumber* number = [NSNumber numberWithFloat:wordSpaceing];
    NSDictionary *dic = @{NSKernAttributeName:number};
    [text addAttributes:dic range:NSMakeRange(0, text.length)];
    return text;
}

/**
 首行缩进
 */
+(NSMutableAttributedString*)GetMutableAttributedSting_FirstLineSpace:(NSMutableAttributedString*)text andLineSpace:(CGFloat)lineSpace AndSpaceing:(CGFloat)FirstLineSpace
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent      = FirstLineSpace;//缩进
    style.lineSpacing               = lineSpace;
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    return text;
}

@end
