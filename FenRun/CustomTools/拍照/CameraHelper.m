//
//  CameraHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/13.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "CameraHelper.h"

@implementation CameraHelper

static id _instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(void)getImageFromCamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO; //可编辑
    
    if(self.type == CameraMine){
        //判断是否可以打开照相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            //摄像头
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.vc presentViewController:picker animated:YES completion:nil];
        }
        else
        {
            NSLog(@"没有摄像头");
            [QMUITips showInfo:@"没有摄像头"];
        }
    }
    else if(self.type == CameraPhotos){
        // 1.判断相册是否可以打开
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        // 2. 创建图片选择控制器
        /**
         typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
         UIImagePickerControllerSourceTypePhotoLibrary, // 相册
         UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
         UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
         }
         */
        // 3. 设置打开照片相册类型(显示所有相簿)
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        // 照相机
        // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 4.设置代理
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        // 5.modal出这个控制器
        //    [self presentViewController:ipc animated:YES completion:nil];
        //    [self.navigationController pushViewController:ipc animated:YES];
        [self.vc presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"finish..");
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        //图片存入相册
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"])
        {
            //获取照片的原图
            UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
            //获取图片裁剪的图
//            UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
            //获取图片裁剪后，剩下的图
//            UIImage* crop = [info objectForKey:UIImagePickerControllerCropRect];
            //先把图片转成NSData
//            UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
//            //压缩图片
//            UIImage* image = [original fixOrientation];
//            image = [self imageWithImageSimple:original scaledToSize:CGSizeMake(kWidth(281), kWidth(160))];
            if(self.didfinishedBlock){
                self.didfinishedBlock(original);
            }
            
            [self.vc dismissViewControllerAnimated:YES completion:nil];
        }
        
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }
    else if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        // 销毁控制器
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        // 设置图片
        UIImage* image = info[UIImagePickerControllerOriginalImage];
        
        //压缩图片
//        image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(48, 48)];
        if(image != nil){ //有时候imag获取nil,导致问题
            if(self.didfinishedBlock){
                self.didfinishedBlock(image);
            }
        }
//        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.vc dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

@end
