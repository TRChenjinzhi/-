//
//  MyCutomCollectionViewCell.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/3.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCutomCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImage*    image;

+(MyCutomCollectionViewCell*)getCellBy:(UICollectionView*)collectionView AndIdentify:(NSString*)identify AndIndexpath:(NSIndexPath*)indexPath;
@end
