//
//  MineModel.m
//  FenRun
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "MineModel.h"

@implementation MineModel

+(MineModel *)getModelByTitle:(NSString *)title andImagName:(NSString *)imageName{
    MineModel* model    = [MineModel new];
    model.title         = title;
    model.imagName      = imageName;
    return model;
}

@end
