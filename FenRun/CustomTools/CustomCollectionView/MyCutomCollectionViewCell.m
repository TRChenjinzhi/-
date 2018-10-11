//
//  MyCutomCollectionViewCell.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/3.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MyCutomCollectionViewCell.h"

@interface MyCutomCollectionViewCell ()
@property (nonatomic,strong)UIImageView* imagV;
@end

@implementation MyCutomCollectionViewCell

+(MyCutomCollectionViewCell*)getCellBy:(UICollectionView*)collectionView AndIdentify:(NSString*)identify AndIndexpath:(NSIndexPath*)indexPath{
    MyCutomCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if(!cell){
        cell = [[MyCutomCollectionViewCell alloc] init];
    }
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    UIImageView* imagV = [UIImageView new];
    self.imagV = imagV;
    [self addSubview:imagV];
    [imagV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(void)setImage:(UIImage *)image{
    _image = image;
    [self.imagV setImage:image];
}

@end
