//
//  CameraHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/13.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^cameraDidFinishedBlock)(UIImage* image);

@interface CameraHelper : NSObject <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,assign)NSInteger type;
@property (nonatomic,weak)UIViewController* vc;
@property (nonatomic,copy)cameraDidFinishedBlock didfinishedBlock;


+(instancetype)sharedInstance;
-(void)getImageFromCamera;

//-(void)

@end
