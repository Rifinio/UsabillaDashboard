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

@end
