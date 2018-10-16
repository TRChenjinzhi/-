//
//  MineWorkOrderVC.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/12.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "MineWorkOrderVC.h"
#import "MineWordOrderDelegate.h"

@interface MineWorkOrderVC ()

@property (nonatomic,strong)UITableView*    tableview;
@property (nonatomic,strong)MineWordOrderDelegate* delegateModel;

@end

@implementation MineWorkOrderVC

-(MineWordOrderDelegate *)delegateModel{
    if(!_delegateModel){
        _delegateModel  = [MineWordOrderDelegate new];
    }
    return _delegateModel;
}

-(UITableView *)tableview{
    if(!_tableview){
        _tableview  = [BaseViewHelper getBaseTableview];
        _tableview.bounces  = YES;
        _tableview.delegate = self.delegateModel;
        _tableview.dataSource= self.delegateModel;
        [_tableview registerClass:[MineWordOrderCell class] forCellReuseIdentifier:@"MineWordOrderCell"];
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

-(void)setUI{
    IMP_BLOCK_SELF(MineWorkOrderVC)
    self.naviView.title = @"工单记录查询";
    self.naviView.backBlock = ^{
        [block_self.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.naviView.mas_bottom);
    }];
    
    self.tableview.mj_header    = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSMutableArray* tmp     = [NSMutableArray new];
        for(int i=0;i<3;i++){
            MineWordOrderModel* model   = [MineWordOrderModel new];
            model.number        = [NSString stringWithFormat:@"%ld",5643126541641+i];
            model.date          = [NSString stringWithFormat:@"2018/8/30 20:%d",10+i];
            if(i == 0){
                model.type      = POS;
                model.state     = sucess;
            }
            if(i == 1){
                model.type      = BlackMenu;
                model.state     = failed;
            }
            if(i == 2){
                model.type      = Hander;
                model.state     = Doing;
            }
            
            [tmp addObject:model];
        }
        block_self.delegateModel.dataSource = tmp;
        [block_self.tableview reloadData];
        
        [block_self.tableview.mj_header endRefreshing];
        [block_self.tableview.mj_footer endRefreshingWithNoMoreData];
    }];
    
    self.tableview.mj_footer    = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
    }];
    
    self.tableview.mj_header.automaticallyChangeAlpha   = YES;
    [self.tableview.mj_header beginRefreshing];
}

@end
