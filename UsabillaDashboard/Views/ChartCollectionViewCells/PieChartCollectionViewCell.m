//
//  PieChartCollectionViewCell.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 20/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "PieChartCollectionViewCell.h"

@interface PieChartCollectionViewCell()
@property(nonatomic, strong) PieChartView *chart;
@end

@implementation PieChartCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _chart = [[PieChartView alloc] init];
        [self.chartView addSubview:self.chart];
        //        self.pieChartView.delegate = self;
        [self.chart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.chartView);
        }];
    }
    return self;
}

@end
