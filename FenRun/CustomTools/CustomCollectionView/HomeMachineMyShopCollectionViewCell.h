//
//  HomeMachineMyShopCollectionViewCell.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/14.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionModel.h"

@interface HomeMachineMyShopCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)MyCollectionModel*   model;

+(HomeMachineMyShopCollectionViewCell*)getCellBy:(UICollectionView*)collectionView AndIdentify:(NSString*)identify AndIndexpath:(NSIndexPath*)indexPath;

@end
