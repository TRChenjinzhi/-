//
//  ScreenHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/11.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "ScreenHelper.h"

static id _instance;
@implementation ScreenHelper

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+(UIImage*)getCurrentScreenImgBy:(UIViewController*)vc{
    UIGraphicsBeginImageContextWithOptions(vc.view.frame.size,NO, 0);
    
    [[UIColor clearColor] setFill];
    
    [[UIBezierPath bezierPathWithRect:vc.view.bounds] fill];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [vc.view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)SaveImagToLoacl:(UIImage *)image andScale:(CGFloat)scale{
//    ALAssetsLibrary * library = [ALAssetsLibrary new];
//
//    NSData * data = UIImageJPEGRepresentation(image, 1.0);
//
//    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];
    
    //保存
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:), NULL);
}

#pragma mark -------------图片保存完后调用的方法-------------------
//图片保存完后调用的方法
- (void)onCompleteCapture:(UIImage *)screenImage didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error){
        //保存失败
#ifdef DEBUG
        NSLog(@"屏幕截图保存相册失败：%@",error);
        [QMUITips showError:@"保存失败"];
#endif
    }else {
        //保存成功
#ifdef DEBUG
        NSLog(@"屏幕截图保存相册成功");
        [QMUITips showSucceed:@"保存成功"];
#endif
    }
    
}

@end
