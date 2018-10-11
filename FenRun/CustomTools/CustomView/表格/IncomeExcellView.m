//
//  IncomeExcellView.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/8.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "IncomeExcellView.h"

#define LineWidth   kWidth(50)
#define LineHeight  kWidth(50)
#define LeftMargin  kWidth(32)
#define BottomMargin kWidth(75)
#define TopMargin   kWidth(15)
#define lineWidthXY kWidth(2)
#define lineWidthSmall   kWidth(0.5)
#define lineZhe     kWidth(1)   //折线
#define HorizontalLineCount 5    //横线数量

@interface PointModel : NSObject
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@end

@implementation PointModel

@end

@interface IncomeExcellView () <UIScrollViewDelegate>

@property (nonatomic,assign)CGFloat     baseMoney;
@property (nonatomic,strong)NSString*   baseMoneyStr;
@property (nonatomic,assign)CGFloat     lineVerticalDistance;
@property (nonatomic,assign)CGFloat     lineHorizontalDistance;
@end

@implementation IncomeExcellView

-(instancetype)initWithFrame:(CGRect)frame{
    self    = [super initWithFrame:frame];
    if(self){
        self.myFrame = frame;
    }
    return self;
}

-(void)setDataSource:(NSArray *)dataSource{
    //起点插入 0
//    NSMutableArray* tmp = [NSMutableArray arrayWithArray:dataSource];
//    [tmp insertObject:[NSNumber numberWithFloat:0.0f] atIndex:0];
//    dataSource  = tmp;
    
    [self removeAllSubviews];
    
    _dataSource = dataSource;
    
    //判断金额的基本单位是什么 （元 ,千元，万元，十万元）
    self.baseMoney  = [self getBaseMoney:dataSource];
    if(self.baseMoneyBlock){
        self.baseMoneyBlock([NSString stringWithFormat:@"单位(%@)",self.baseMoneyStr]);
    }
    
    self.lineVerticalDistance       = LineHeight;
    self.lineHorizontalDistance     = LineWidth;
    
    CGFloat scrollviewHeight        = self.frame.size.height;
    
    //开始画图
    //背景色
    UIView* backgroundView  = [UIView new];
    backgroundView.backgroundColor  = [UIColor whiteColor];
    [self addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.top.equalTo(self);
        make.right.equalTo(self.mas_right).offset(0);
    }];
    
    //Y轴
    [self drawLineByStart:CGPointMake(LeftMargin, TopMargin)
                   andEnd:CGPointMake(LeftMargin, self.frame.size.height-BottomMargin)
             AndLineColor:LineColor
             AndLineWidth:lineWidthXY
             AndSuperView:backgroundView];
    
    //scrollview
    UIScrollView* scrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
    scrollview.showsVerticalScrollIndicator     = NO;
    scrollview.showsHorizontalScrollIndicator   = NO;
    scrollview.bounces                          = NO;
    if (@available(iOS 11.0, *)) {
        scrollview.contentInsetAdjustmentBehavior   = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    scrollview.contentSize                      = CGSizeMake(_dataSource.count*LineWidth+kWidth(10), scrollviewHeight);
    scrollview.delegate                         = self;
    [backgroundView addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundView.mas_left).offset(LeftMargin);
        make.top.equalTo(backgroundView.mas_top).offset(0);
        make.right.equalTo(backgroundView.mas_right);
        make.bottom.equalTo(backgroundView.mas_bottom);
    }];
    
    //x轴
    [self drawLineByStart:CGPointMake(0, scrollviewHeight-BottomMargin)
                   andEnd:CGPointMake(scrollview.contentSize.width, scrollviewHeight-BottomMargin)
             AndLineColor:LineColor
             AndLineWidth:lineWidthXY
             AndSuperView:scrollview];
    
    //隔栏线 横
    for (int i=0 ;i<HorizontalLineCount ;i++) {
        [self drawLineByStart:CGPointMake(0, i*self.lineVerticalDistance+TopMargin)
                       andEnd:CGPointMake(scrollview.contentSize.width, i*self.lineVerticalDistance+TopMargin)
                 AndLineColor:LineColor
                 AndLineWidth:lineWidthSmall
                 AndSuperView:scrollview];
        UILabel* YTipsLB    = [LabelHelper CreateLabelByText:[NSString stringWithFormat:@"%ld",(long)i*2] AndFont:kFONT(11) AndTextColor:APPSubTextColor AndTextAligemt:NSTextAlignmentCenter];
        YTipsLB.numberOfLines   = 2;
        [backgroundView addSubview:YTipsLB];
        [YTipsLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backgroundView.mas_left);
            make.right.equalTo(scrollview.mas_left);
            make.bottom.equalTo(scrollview.mas_bottom).offset(-((i*self.lineVerticalDistance)-[LabelHelper GetLabelHight:kFONT(11) AndText:YTipsLB.text AndWidth:LeftMargin]/2) - BottomMargin);
        }];
    }
    
//    //左下角 0
//    UILabel* ZeroLB         = [LabelHelper CreateLabelByText:@"0" AndFont:kFONT(11) AndTextColor:APPSubTextColor AndTextAligemt:NSTextAlignmentCenter];
//    [backgroundView addSubview:ZeroLB];
//    [ZeroLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(scrollview.mas_left);
//        make.top.equalTo(scrollview.mas_bottom).offset(-(BottomMargin-kWidth(12)));
//        make.height.mas_offset(kWidth(20));
//    }];
    
    //单位标示
    UILabel* baseStrLabel   = [LabelHelper CreateLabelByText:[NSString stringWithFormat:@"单位:%@",self.baseMoneyStr] AndFont:kFONT(12) AndTextColor:APPTextColor AndTextAligemt:NSTextAlignmentCenter];
    [backgroundView addSubview:baseStrLabel];
    [baseStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backgroundView.mas_right).offset(-kWidth(12));
        make.bottom.equalTo(backgroundView.mas_bottom).offset(-kWidth(12));
    }];
    
    UIView* pointView       = [UIView new];
    pointView.backgroundColor   = self.lineColor;
    [pointView.layer setCornerRadius:kWidth(8)/2];
    pointView.layer.masksToBounds= YES;
    [backgroundView addSubview:pointView];
    [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(baseStrLabel.mas_left).offset(-kWidth(8));
        make.width.and.height.mas_offset(kWidth(8));
        make.centerY.equalTo(baseStrLabel.mas_centerY);
    }];
    
    //画X轴 标示
    for(int i=0;i<_dataSource.count+1;i++){
        UILabel* XTipsLB    = [LabelHelper CreateLabelByText:[NSString stringWithFormat:@"%ld",(long)(i)] AndFont:kFONT(11) AndTextColor:APPSubTextColor AndTextAligemt:NSTextAlignmentCenter];
        [scrollview addSubview:XTipsLB];
        CGFloat strWidth    = [LabelHelper GetLabelWidth:kFONT(11) AndText:XTipsLB.text];
        CGFloat startX      = (i) *self.lineHorizontalDistance;
        if(i == 0){
            XTipsLB.frame       = CGRectMake(startX, scrollviewHeight-BottomMargin+kWidth(12), strWidth, kWidth(20));
        }
        else{
            XTipsLB.frame       = CGRectMake(startX-strWidth/2, scrollviewHeight-BottomMargin+kWidth(12), strWidth, kWidth(20));
        }
        
        [scrollview addSubview:XTipsLB];
    }
    
    //根据每个节点 画线 和 画圆
    //走势线
    CGPoint startP  = CGPointMake(0, scrollviewHeight-BottomMargin);
    NSMutableArray* pointArray  = [NSMutableArray array];
    for (int i=0 ;i<dataSource.count ;i++) {
        NSNumber* number    = dataSource[i];
        CGFloat Height      = [number floatValue];
        CGFloat pHeight      = (CGFloat)(Height/(self.baseMoney*2))*self.lineVerticalDistance;
        if(pHeight > scrollviewHeight){
            pHeight = scrollviewHeight;
        }
//        [self drawLineByStart:startP
//                       andEnd:CGPointMake((i+1)*self.lineHorizontalDistance, scrollviewHeight-BottomMargin - pHeight)
//                 AndLineColor:self.lineColor
//                 AndLineWidth:lineZhe
//                 AndSuperView:scrollview];
        startP   = CGPointMake((i+1)*self.lineHorizontalDistance, scrollviewHeight-BottomMargin - pHeight);
//        if(i == dataSource.count-1){ //最后一个点不画
//            break;
//        }
        PointModel* model   = [PointModel new];
        model.x             = startP.x;
        model.y             = startP.y;
        [pointArray addObject:model];
    }
    
    //画颜色区间
    [self createSqure:pointArray andStartPoint:CGPointMake(0, scrollviewHeight-BottomMargin) andSuperView:scrollview AndLineColor:self.fillColor AndLineWidth:lineWidthSmall andHeight:scrollviewHeight];
    
    startP  = CGPointMake(0, scrollviewHeight-BottomMargin);
    for (int i=0 ;i<dataSource.count ;i++) {
        NSNumber* number    = dataSource[i];
        CGFloat Height      = [number floatValue];
        CGFloat pHeight      = (CGFloat)(Height/(self.baseMoney*2))*self.lineVerticalDistance;
        if(pHeight > scrollviewHeight){
            pHeight = scrollviewHeight;
        }
        [self drawLineByStart:startP
                       andEnd:CGPointMake((i+1)*self.lineHorizontalDistance, scrollviewHeight-BottomMargin - pHeight)
                 AndLineColor:self.lineColor
                 AndLineWidth:lineZhe
                 AndSuperView:scrollview];
        startP   = CGPointMake((i+1)*self.lineHorizontalDistance, scrollviewHeight-BottomMargin - pHeight);
        //        if(i == dataSource.count-1){ //最后一个点不画
        //            break;
        //        }
//        PointModel* model   = [PointModel new];
//        model.x             = startP.x;
//        model.y             = startP.y;
//        [pointArray addObject:model];
    }
    
    //画点
    for (int i=0;i<pointArray.count;i++) {
        PointModel* model   = pointArray[i];
        //画点
        CGFloat pointRadius = kWidth(8);
        if(self.type == month){
            pointRadius = kWidth(8);
        }
        else if(self.type == day){
            pointRadius = kWidth(8);
        }
        //        [self drawCircle:startP AndRadius:pointRadius AndColor:excelPointColor AndSuperView:backgroundView];
        UIButton* pointBtn  = [[UIButton alloc] initWithFrame:CGRectMake(model.x-pointRadius/2, model.y-pointRadius/2, pointRadius, pointRadius)];
        pointBtn.tag        = i;
        [pointBtn.layer setCornerRadius:pointRadius/2];
        pointBtn.layer.masksToBounds    = YES;
        [pointBtn setBackgroundImage:[Color_Image_Helper createImageWithColor:self.lineColor] forState:UIControlStateNormal];
        [pointBtn addTarget:self action:@selector(pointBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:pointBtn];
    }
}

-(void)pointBtnAction:(UIButton*)btn{
    if(self.btnBlock){
        NSNumber* number    = self.dataSource[btn.tag];
        CGFloat Height      = [number floatValue];
        CGFloat pHeight     = (CGFloat)(Height/self.baseMoney);
        self.btnBlock(pHeight,self.baseMoneyStr,btn);
    }
}

-(CGFloat)getBaseMoney:(NSArray*)array{
    CGFloat money = 0.0f;
    for (NSNumber* item in array) {
        CGFloat itemMoney   = [item floatValue];
//        money += itemMoney;
        if(itemMoney >= money){
            money   = itemMoney;
        }
    }
    
//    money   = money / array.count;              //每天平均收入
    
    if(0 >= money){                             //零收入
        self.baseMoneyStr   =   @"角";
        return 0.1;
    }
    else if(1 <= money && money < 10){         //1元
        self.baseMoneyStr   =   @"元";
        return 1;
    }
    else if(10 <= money && money < 100){         //10元
        self.baseMoneyStr   =   @"十元";
        return 10;
    }
    else if(100 <= money && money < 100*10){      //百元
        self.baseMoneyStr   =   @"百元";
        return 100;
    }
    else if(100*10 <= money && money < 100*100){    //千元
        self.baseMoneyStr   =   @"千元";
        return 100*10;
    }
    else if(100*100 <= money && money < 100*100*10){  //万元
        self.baseMoneyStr   =   @"万元";
        return 100*100;
    }
    else if(100*100*10 <= money && money < 100*100*100){
        self.baseMoneyStr   =   @"十万元";
        return 100*100*10;                          //十万元
    }
    else if(100*100*100 <= money && money < 100*100*100*10){
        self.baseMoneyStr   =   @"百万元";
        return 100*100*100;                          //百万元
    }
    else{
        self.baseMoneyStr   =   @"千万元";
        return 100*100*100*10;                        //千万元
    }
    
}

-(void)drawLineByStart:(CGPoint)startP andEnd:(CGPoint)endP AndLineColor:(UIColor*)lineColor AndLineWidth:(CGFloat)width AndSuperView:(UIView*)superView{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:startP];
    // 其他点
    [linePath addLineToPoint:endP];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    
    lineLayer.lineWidth = width;
    lineLayer.strokeColor = lineColor.CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = lineColor.CGColor; // 默认为blackColor
    
    [superView.layer addSublayer:lineLayer];
}

-(void)drawCircle:(CGPoint)point AndRadius:(CGFloat)radius AndColor:(UIColor*)color AndSuperView:(UIView*)superView {
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
//    solidLine.lineWidth = 2.0f ;
//    solidLine.strokeColor = [UIColor orangeColor].CGColor;
    solidLine.fillColor = color.CGColor;
    CGPathAddEllipseInRect(solidPath, nil, CGRectMake(point.x-radius,  point.y-radius, radius*2, radius*2));
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    [superView.layer addSublayer:solidLine];
}

-(void)createSqure:(NSArray*)array andStartPoint:(CGPoint)startPoint andSuperView:(UIView*)superView AndLineColor:(UIColor*)lineColor AndLineWidth:(CGFloat)width andHeight:(CGFloat)height{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.dataSource.count*self.lineVerticalDistance, height);
    gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)lineColor.CGColor];
    
    gradientLayer.locations=@[@0,@1];
    gradientLayer.startPoint = CGPointMake(0.0,1);
    gradientLayer.endPoint = CGPointMake(0,0);
    
//    UIColor *color = self.fillColor;
//    [color set]; //设置线条颜色
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 0.5;
    
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    [path moveToPoint:startPoint];//起点
    
    for (PointModel* model in array) {
        [path addLineToPoint:CGPointMake(model.x, model.y-lineZhe)];
    }
    
    //最后一个点的 Y 坐标要归零
    PointModel* item    = (PointModel*)[array lastObject];
    [path addLineToPoint:CGPointMake(item.x, startPoint.y)];
    
    // Draw the lines
//    [path addLineToPoint:CGPointMake(300.0, 100.0)];
//    [path addLineToPoint:CGPointMake(260, 200)];
//    [path addLineToPoint:CGPointMake(100.0, 200)];
//    [path addLineToPoint:CGPointMake(100, 70.0)];
    [path closePath];//第五条线通过调用closePath方法得到的
    
    //    [path stroke];//Draws line 根据坐标点连线
    [path fill];//颜色填充
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    
//    lineLayer.lineWidth = width;
//    lineLayer.strokeColor = lineColor.CGColor;
    lineLayer.path = path.CGPath;
//    lineLayer.fillColor = lineColor.CGColor; // 默认为blackColor
    gradientLayer.mask  = lineLayer;
    
    [superView.layer addSublayer:gradientLayer];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(self.scrollBeginBlock){
        self.scrollBeginBlock();
    }
}

@end
