//
//  ChartCollectionViewCell.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "ChartCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "ChartCellViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ChartCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ChartCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        _titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 0, 10));
            make.height.equalTo(@33);
        }];

        UIView *chartView = [UIView new];
        chartView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:chartView];
        [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.right.bottom.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 10, 10));
        }];
    }
    return self;
}

- (void)setViewModel:(ChartCellViewModel *)viewModel
{
    _viewModel = viewModel;
    RAC(self.titleLabel, text) = RACObserve(self.viewModel, title);
}

@end
