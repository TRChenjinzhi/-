//
//  TabBarViewController.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/3.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "TabBarViewController.h"
#import "TestTabBar.h"

@interface TabBarViewController () <AxcAE_TabBarDelegate>

@property (nonatomic,strong)NSArray*        arrVC;
@property (nonatomic,strong)NSArray*        arrItem;
@property (nonatomic, strong)AxcAE_TabBar*  axcTabBar;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self setUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)initData{
    //初始化VC
    //初始化Items
    [self initVC];
}

-(void)initVC{
    
    MineVC* mineVC  = [MineVC new];
    mineVC.loginOutBlock = ^{
        [AppConfig saveUserInfo:[LoginHelper new]];
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    NSArray <NSDictionary *>*VCArray =
    @[@{@"vc":[[BaseNaviViewController alloc] initWithRootViewController:[UIViewController new]],
        @"normalImg":@"menu_home_nor",
        @"selectImg":@"menu_home_dwn",
        @"itemTitle":@"首页"},
      @{@"vc":[[BaseNaviViewController alloc] initWithRootViewController:[DataVC new]],
        @"normalImg":@"menu_income_nor",
        @"selectImg":@"menu_income_dwn",
        @"itemTitle":@"数据"},
      @{@"vc":[[BaseNaviViewController alloc] initWithRootViewController:mineVC],
        @"normalImg":@"menu_me_nor",
        @"selectImg":@"menu_me_dwn",
        @"itemTitle":@"个人中心"}];
    self.arrVC = VCArray;
}

-(UIImage*)getImage:(NSString* )name{
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(void)setUI{
    // 1.1 设置一个保存构造器的数组
    NSMutableArray *tabBarConfs = @[].mutableCopy;
    // 1.2 设置一个保存VC的数组
    NSMutableArray *tabBarVCs = @[].mutableCopy;
    [self.arrVC enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 2.根据集合来创建TabBar构造器
        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
        
        if (idx == 2000 ) { // 如果是中间的
//            [model.backgroundImageView setImage:UIImageMake(@"btn_index_menu_put")];
//            [model.backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
//            model.bulgeHeight   = 20;
//            // 设置凸出
//            model.bulgeStyle = AxcAE_TabBarConfigBulgeStyleCircular;
//            // 设置成纯文字展示
//            model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTitle;
////            // 文字为加号
//            model.itemTitle = @"提现";
////            // 字号大小
//            model.titleLabel.font = kFONT(12);
//            model.normalColor = [UIColor whiteColor]; // 未选中是灰色加号
//            model.selectColor = [UIColor whiteColor];   // 选中后为白色加号
//            // 让Label上下左右全边距 稍微向上拉一点
//            model.componentMargin = UIEdgeInsetsMake(22, 0, 0, 0 );
//            // 未选中状态是白色
//            model.normalBackgroundColor = [UIColor whiteColor];
//            // 选中为橘里橘气
//            model.selectBackgroundColor = [UIColor whiteColor];
//            // 设置大小/边长
//            model.itemSize = CGSizeMake(70, 70); // 自动以长款中最大值进行切圆
        }
        else{
            // 3.item基础数据三连
            [model.backgroundImageView setImage:UIImageMake(@"nav_line")];
            model.itemTitle = [obj objectForKey:@"itemTitle"];
            model.selectImageName = [obj objectForKey:@"selectImg"];
            model.normalImageName = [obj objectForKey:@"normalImg"];
            model.titleLabel.font = kFONT(11);
            model.alignmentStyle  = AxcAE_TabBarConfigAlignmentStyleCenter;
            model.icomImgViewSize   = CGSizeMake(28, 28);
            model.selectColor       = APPThemeBlue;
            model.componentMargin = UIEdgeInsetsMake(5, 0, 10, 0 );
            model.pictureWordsMargin= 0;
            model.itemLayoutStyle = AxcAE_TabBarItemLayoutStyleTopPictureBottomTitle;
        }
        
//        model.normalTintColor   = RGBA(242, 242, 242, 1);
//        model.selectTintColor   = [UIColor orangeColor];
        model.normalBackgroundColor = [UIColor whiteColor];
        model.selectBackgroundColor = [UIColor whiteColor];
        
        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
        // 示例中为了方便就在这写了
        UIViewController *vc = [obj objectForKey:@"vc"];
//        vc.view.backgroundColor = RGBA(246, 246, 246, 1);
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f
                                                  green:arc4random()%255/255.f
                                                   blue:arc4random()%255/255.f alpha:1];
        // 5.将VC添加到系统控制组
        [tabBarVCs addObject:vc];
        // 5.1添加构造Model到集合
        [tabBarConfs addObject:model];
    }];
    // 使用自定义的TabBar来帮助触发凸起按钮点击事件
    TestTabBar *testTabBar = [TestTabBar new];
    
    //去掉tabBar顶部线条
//    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context,LineColor.CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    //以下两个方法缺一不可
//    [testTabBar setShadowImage:img];
//    [testTabBar setBackgroundImage:[[UIImage alloc]init]];
//    testTabBar.backgroundColor  = [UIColor whiteColor];
    
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, TabBarHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [testTabBar setBackgroundImage:img];
    [testTabBar setShadowImage:img];
    testTabBar.backgroundColor  = [UIColor whiteColor];
    
    [self setValue:testTabBar forKey:@"tabBar"];
    // 5.2 设置VCs -----
    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
    self.viewControllers = tabBarVCs;
    //////////////////////////////////////////////////////////////////////////
    // 注：这里方便阅读就将AE_TabBar放在这里实例化了 使用懒加载也行
    // 6.将自定义的覆盖到原来的tabBar上面
    // 这里有两种实例化方案：
    // 6.1 使用重载构造函数方式：
    //    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
    // 6.2 使用Set方式：
    self.axcTabBar = [AxcAE_TabBar new] ;
    self.axcTabBar.tabBarConfig = tabBarConfs;
    // 7.设置委托
    self.axcTabBar.delegate = self;
    // 8.添加覆盖到上边
    [self.tabBar addSubview:self.axcTabBar];
    [self addLayoutTabBar]; // 10.添加适配
}

// 9.实现代理，如下：
- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
    // 通知 切换视图控制器
    [self setSelectedIndex:index];
    // 自定义的AE_TabBar回调点击事件给TabBarVC，TabBarVC用父类的TabBarController函数完成切换
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    if(self.axcTabBar){
        
        self.axcTabBar.selectIndex = selectedIndex;
    }
}

// 10.添加适配
- (void)addLayoutTabBar{
    // 使用重载viewDidLayoutSubviews实时计算坐标 （下边的 -viewDidLayoutSubviews 函数）
    // 能兼容转屏时的自动布局
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.axcTabBar.frame = self.tabBar.bounds;
    [self.axcTabBar viewDidLayoutItems];
}


@end
