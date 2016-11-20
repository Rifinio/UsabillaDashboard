//
//  HorizontalBarChartCollectionViewCell.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 20/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "HorizontalBarChartCollectionViewCell.h"

@interface HorizontalBarChartCollectionViewCell()

@property (nonatomic, strong) HorizontalBarChartView* chart;

@end


@implementation HorizontalBarChartCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _chart = [[HorizontalBarChartView alloc] init];
        self.chart.fitBars = YES;
        [self.chartView addSubview:self.chart];
        //            self.chart.delegate = self;
        [self.chart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.chartView);
        }];
    }
    return self;
}

@end
