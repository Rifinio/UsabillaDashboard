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
@property (nonatomic, strong) UILabel *moreLabel;
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

        _moreLabel = [UILabel new];
        self.moreLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        self.moreLabel.textColor = [UIColor flatBlueColor];
        self.moreLabel.textAlignment = NSTextAlignmentRight;
        self.moreLabel.text = @"more >";
        [self.contentView addSubview:self.moreLabel];
        [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@33);
            make.width.equalTo(@100);
        }];

        _titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        self.titleLabel.textColor = [UIColor flatMintColor];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 20, 0, 10));
            make.right.equalTo(self.moreLabel);
            make.height.equalTo(@33);
        }];

        _chartView = [UIView new];
        self.chartView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.chartView];
        [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.right.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
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
}

@end
