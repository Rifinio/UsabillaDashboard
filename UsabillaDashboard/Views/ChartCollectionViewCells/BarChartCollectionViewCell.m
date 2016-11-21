//
//  BarChartCollectionViewCell.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 20/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "BarChartCollectionViewCell.h"

@interface BarChartCollectionViewCell()

@property (nonatomic, strong) BarChartView* chart;

@end

@implementation BarChartCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _chart = [[BarChartView alloc] init];
        [self.chartView addSubview:self.chart];
        //            self.chartView.delegate = self;
        [self.chart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.chartView);
        }];
    }
    return self;
}

- (void) setChartView:(ChartViewBase *)chartView dataPoints:(NSArray<NSString *> *)keys values:(NSArray<NSNumber *> *)values
{
    [self setBarChart:(BarChartView *)self.chart dataPoints:keys values:values];
}

- (void)setBarChart:(BarChartView *)chartView dataPoints:(NSArray<NSString *> *)points values:(NSArray<NSNumber *> *)values
{
    chartView.noDataText = @"no data yet !";
    chartView.descriptionText = @"";

    // Create data entries for every data point
    NSMutableArray <BarChartDataEntry *> *dataEntries = [NSMutableArray array];
    for (int i = 0; i< points.count; i++) {
        BarChartDataEntry *dataEntry = [[BarChartDataEntry alloc] initWithX:i y:values[i].doubleValue];
        [dataEntries addObject:dataEntry];
    }

    // create a data set from all the data entries, and TITLE
    BarChartDataSet *dataSet = [[BarChartDataSet alloc] initWithValues:dataEntries label:@""];
    // set colors with predefined charts colors
    dataSet.colors = self.colors;

    // create Chart Data to create the barChartView
    BarChartData *chartData = [[BarChartData alloc] initWithDataSet:dataSet];

    [chartView animateWithXAxisDuration:1.5 yAxisDuration:1.5];
    chartView.data = chartData;
}

@end
