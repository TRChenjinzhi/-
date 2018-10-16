//
//  ChartsPieView.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/13.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "ChartsPieView.h"
#import "FenRun-Bridging-Header.h"

@interface ChartsPieView ()

@property (nonatomic,strong)PieChartView* pieChartView;

@end

@implementation ChartsPieView

-(void)createUI{
    self.pieChartView = [[PieChartView alloc] init];
    self.pieChartView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pieChartView];
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //1. 基本样式
    [self.pieChartView setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的间隙
    self.pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
    self.pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    self.pieChartView.drawCenterTextEnabled = YES;//是否显示区块文本
    
    
    //2. 设置饼状图中间的空心样式
    self.pieChartView.drawHoleEnabled = NO;//饼状图是否是空心
    self.pieChartView.holeRadiusPercent = 0.5;//空心半径占比
    self.pieChartView.holeColor = [UIColor clearColor];//空心颜色
    self.pieChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
    self.pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
    
    //3.设置饼状图中心的文本
    if (self.pieChartView.isDrawHoleEnabled == YES) {
        self.pieChartView.drawCenterTextEnabled = YES;//是否显示中间文字
        //普通文本
        //        self.pieChartView.centerText = @"饼状图";//中间文字
        //富文本
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"饼状图"];
        [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                    NSForegroundColorAttributeName: [UIColor orangeColor]}
                            range:NSMakeRange(0, centerText.length)];
        self.pieChartView.centerAttributedText = centerText;
    }
    
    //4. 设置饼状图描述
    
    
    //5.设置饼状图图例样式
    self.pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    self.pieChartView.legend.formToTextSpace = 5;//文本间隔
    self.pieChartView.legend.font = [UIFont systemFontOfSize:12];//字体大小
    self.pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
//    self.pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    self.pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    self.pieChartView.legend.formSize = 12;//图示大小
    self.pieChartView.legend.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    self.pieChartView.legend.orientation = ChartLegendOrientationHorizontal;
//    self.pieChartView.legend.formLineDashLengths = @[@115,@115,@115,@115,@115];
    
    //初始化数据
    self.nameArray = [NSMutableArray arrayWithArray:@[@"闪付",@"普通结算",@"闪付2.0",@"快捷支付",@"云闪付"]];
    self.dataArray = [NSMutableArray arrayWithArray:@[@"30",@"20",@"50",@"10",@"40"]];
    [self setData];
}

-(void)setData{
    //每个区块的数据
    //每个区块的名称或描述
    NSMutableArray *arr = self.dataArray;
    NSMutableArray *nameArr = self.nameArray;
//    for (PieChartData *model in self.pieCharModel.pieChart) {
//        [arr addObject:model.totalamt];//@[@"8.54",@"3.26",@"2"];
//        [nameArr addObject:model.typename];
//    }
    NSMutableArray *values = [[NSMutableArray alloc] init];
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    for (int i = 0; i < arr.count; i++)
    {
        NSString * aaa = arr[i];
        double bb = aaa.doubleValue;
        [values addObject:[[PieChartDataEntry alloc] initWithValue: bb label: nameArr[i]]];
    }
    //dataSet
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@""];
    dataSet.drawValuesEnabled = YES;//是否绘制显示数据
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    dataSet.colors = colors;//区块颜色
    dataSet.sliceSpace = 5;//相邻区块之间的间距
    dataSet.selectionShift = 8;//选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
    //数据与区块之间的用于指示的折线样式
    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
    dataSet.valueLineWidth = 1;//折线的粗细
    dataSet.valueLineColor = [UIColor brownColor];//折线颜色
    //data
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    formatter.maximumFractionDigits = 0;//小数位数
    formatter.multiplier = @1.f;
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];//设置显示数据格式
    [data setValueTextColor:[UIColor brownColor]];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    self.pieChartView.data = data;
    [ self.pieChartView setNeedsDisplay];
}

@end
