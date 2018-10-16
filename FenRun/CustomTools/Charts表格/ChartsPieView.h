//
//  ChartsPieView.h
//  乐速益
//
//  Created by chenjinzhi on 2018/10/13.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChartsPieView : UIView

@property (nonatomic,strong)NSMutableArray* nameArray; //名称
@property (nonatomic,strong)NSMutableArray* dataArray;//数据

-(void)createUI;
-(void)setData;

@end

NS_ASSUME_NONNULL_END
