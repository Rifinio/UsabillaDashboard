//
//  ChartCollectionViewCell.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "ChartCollectionViewCell.h"
#import "ChartCellViewModel.h"

@interface ChartCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray *chartKeys;
@property (nonatomic, strong) NSArray *chartValues;

@property (nonatomic, strong) ChartViewBase *chart;

@end

@implementation ChartCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor flatWhiteColor];

        _titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        self.titleLabel.textColor = [UIColor flatMintColor];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 0, 10));
            make.height.equalTo(@33);
        }];

        _chartView = [UIView new];
        self.chartView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.chartView];
        [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.right.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 10, 10));
        }];

        UIView *bottomLineView = [UIView new];
        bottomLineView.backgroundColor = [UIColor flatGrayColor];
        [self.contentView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.right.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(20);
            make.bottom.equalTo(self.contentView);
        }];
    }

    return self;
}

- (void)setViewModel:(ChartCellViewModel *)viewModel
{
    _viewModel = viewModel;

    RAC(self.titleLabel, text) = RACObserve(self.viewModel, title);
    RAC(self, chartKeys) = [[RACObserve(self.viewModel, keyValues) ignore:nil]
                            map:^NSArray *(NSDictionary *keyValues) {
                                return keyValues[@"keys"];
                            }];
    RAC(self, chartValues) = [[RACObserve(self.viewModel, keyValues) ignore:nil]
                            map:^NSArray *(NSDictionary *keyValues) {
                                return keyValues[@"values"];
                            }];

    @weakify(self);
    [[RACObserve(self, chartValues)
      filter:^BOOL(NSArray *array) {
          return array.count > 0;
      }] subscribeNext:^(__unused id _) {
          @strongify(self);
          NSLog(@"rac keys : %@", self.chartKeys);
          NSLog(@"rac values : %@", self.chartValues);
          [self setChartView:self.chart dataPoints:self.chartKeys values:self.chartValues];
      }];
}

#pragma mark setup chart views for different types

- (void) setChartView:(ChartViewBase *)chartView dataPoints:(NSArray<NSString *> *)keys values:(NSArray<NSNumber *> *)values
{
    NSAssert((keys.count || values.count), @"chart key and values cant be nil");
    switch (self.viewModel.chartType) {
        case ChartTypePie:
        {
            [self setPieChart:(PieChartView *)self.chart dataPoints:keys values:values];
            break;
        }
        case ChartTypeHorizontalBars: {
            [self setBarChart:(HorizontalBarChartView *)self.chart dataPoints:keys values:values];
        }
        case ChartTypeVerticalBars: {
            [self setBarChart:(BarChartView *)self.chart dataPoints:keys values:values];
            break;
        }
        default:
            break;
    }
}

- (void)setPieChart:(PieChartView *)pieChartView dataPoints:(NSArray<NSString *> *)points values:(NSArray<NSNumber *> *)values
{
    NSAssert((points || values), @"cant be nil");

    pieChartView.noDataText = @"no data yet !";
    pieChartView.descriptionText = @"this is monthly usage !";

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
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:dataEntries label:@"Units Sold"];
    // set colors with predefined charts colors
    dataSet.colors = [ChartColorTemplates colorful];

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

- (void)setBarChart:(BarChartView *)chartView dataPoints:(NSArray<NSString *> *)points values:(NSArray<NSNumber *> *)values
{
    chartView.noDataText = @"no data yet !";
    chartView.descriptionText = @"this is monthly usage !";

    // Create data entries for every data point
    NSMutableArray <BarChartDataEntry *> *dataEntries = [NSMutableArray array];
    for (int i = 0; i< points.count; i++) {
        BarChartDataEntry *dataEntry = [[BarChartDataEntry alloc] initWithX:i y:values[i].doubleValue];
        [dataEntries addObject:dataEntry];
    }

    // create a data set from all the data entries, and TITLE
    BarChartDataSet *dataSet = [[BarChartDataSet alloc] initWithValues:dataEntries label:@"Units Sold"];
    // Custom coloring
    //set colors with an array or only one color
    //    dataSet.colors = @[[UIColor redColor]];
    // set colors with predefined charts colors
    dataSet.colors = [ChartColorTemplates joyful];

    // create Chart Data to create the barChartView
    BarChartData *chartData = [[BarChartData alloc] initWithDataSet:dataSet];

    //    self.barChartView.xAxis.labelPosition = XAxisLabelPositionBottom;

    //    self.barChartView.animate[(xAxisDuration: 2.0, yAxisDuration: 2.0)
    [chartView animateWithXAxisDuration:2.0 yAxisDuration:2.0];
    chartView.data = chartData;
}
@end
