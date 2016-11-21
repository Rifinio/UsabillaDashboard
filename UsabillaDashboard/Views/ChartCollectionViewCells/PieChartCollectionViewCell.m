//
//  PieChartCollectionViewCell.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 20/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "PieChartCollectionViewCell.h"

@interface PieChartCollectionViewCell() <ChartViewDelegate>

@property (nonatomic, strong) PieChartView *chart;
@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSArray *values;

@end

@implementation PieChartCollectionViewCell


- (void)prepareForReuse
{
    self.selectedLabel.text = @"";
    [self.chart reloadInputViews];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _chart = [[PieChartView alloc] init];
        [self.chartView addSubview:self.chart];
        self.chart.delegate = self;
        [self.chart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.chartView);
        }];

        _selectedLabel = [UILabel new];
        self.selectedLabel.textColor = [UIColor flatPlumColor];
        self.selectedLabel.textAlignment = NSTextAlignmentCenter;
        self.selectedLabel.numberOfLines = 2;
        [self.chartView addSubview:self.selectedLabel];
        [self.selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@55);
            make.width.equalTo(@120);
            make.center.equalTo(self.chartView);
        }];

    }
    return self;
}

- (void) setChartView:(ChartViewBase *)chartView dataPoints:(NSArray<NSString *> *)keys values:(NSArray<NSNumber *> *)values
{
    [self setPieChart:(PieChartView *)self.chart dataPoints:keys values:values];
}

- (void)setPieChart:(PieChartView *)pieChartView dataPoints:(NSArray<NSString *> *)points values:(NSArray<NSNumber *> *)values
{
    NSAssert((points || values), @"cant be nil");

    self.keys = points;
    self.values = values;

    pieChartView.noDataText = @"no data yet !";
    pieChartView.descriptionText = @"";

    // set the legend properties
    ChartLegend *l = pieChartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 0.0;

    // Create data entries for every data point
    NSMutableArray <PieChartDataEntry *> *dataEntries = [NSMutableArray array];
    for (int i = 0; i< points.count; i++) {
        double value = [values[i] doubleValue];
        PieChartDataEntry *dataEntry = [[PieChartDataEntry alloc] initWithValue:value label:points[i]];
        [dataEntries addObject:dataEntry];
    }

    // create a data set from all the data entries, and TITLE
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:dataEntries label:@""];
    // set colors with predefined charts colors
    dataSet.colors = self.colors;

    // create Chart Data to create the barChartView
    PieChartData *chartData = [[PieChartData alloc] initWithDataSet:dataSet];

    //custom number formatter to show %
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @(1.f);
    pFormatter.percentSymbol = @" %";
    [chartData setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [chartData setValueFont:[UIFont boldSystemFontOfSize:14.0f]];
    [chartData setValueTextColor:UIColor.whiteColor];

    [pieChartView animateWithXAxisDuration:2.0 yAxisDuration:2.0];
    pieChartView.data = chartData;
}

-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight
{
    PieChartDataEntry *pieEntry = (PieChartDataEntry *)entry;
    NSString *selectedStr = [NSString stringWithFormat:@"%@\n%.2f %%", pieEntry.label, pieEntry.value];
    self.selectedLabel.text = selectedStr;
}

@end
