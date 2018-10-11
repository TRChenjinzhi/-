//
//  ScreenHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/11.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenHelper : NSObject

+(instancetype)sharedInstance;

+(UIImage*)getCurrentScreenImgBy:(UIViewController*)vc;

-(void)SaveImagToLoacl:(UIImage *)image andScale:(CGFloat)scale;

@end
