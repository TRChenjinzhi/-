//
//  MineModel.h
//  FenRun
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineModel : NSObject

@property (nonatomic,copy)NSString* imagName;
@property (nonatomic,copy)NSString* title;

+(MineModel*)getModelByTitle:(NSString*)title andImagName:(NSString*)imageName;

@end

NS_ASSUME_NONNULL_END
