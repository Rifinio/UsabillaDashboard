//
//  DashboardViewModel.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "DashboardViewModel.h"
#import "FeedbackStore.h"
#import "ChartCellViewModel.h"

@interface DashboardViewModel()

@property (nonatomic, strong, readonly) FeedbackStore *store;
@property (nonatomic, strong) NSArray *feedBackList;

@end

@implementation DashboardViewModel

- (instancetype)initWithStore:(FeedbackStore *)feedbackStore
{
    self = [super init];
    if (self) {
        _store = feedbackStore;
        RAC(self, feedBackList) = [[self.store fetchFeedBack] startWith:@[]];
        _hasUpdatedContent = [RACObserve(self, feedBackList) mapReplace:@YES];
    }
    return self;
}

- (NSString *)title
{
    return @"Dashboard";
}

- (ChartCellViewModel *)viewModelForCellAtIndex:(NSIndexPath *)indexPath
{
    //Create custom view model for each cell
    ChartCellViewModel *viewModel;

    switch (indexPath.row) {
        case 0:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store];
            viewModel.chartType = ChartTypePie;
            viewModel.title = @"Browsers";
            break;
        case 1:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store];
            viewModel.chartType = ChartTypeVerticalBars;
            viewModel.title = @"Platform";
            break;
        case 2:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store];
            viewModel.chartType = ChartTypePie;
            viewModel.title = @"Geolocation";
            break;
        case 3:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store];
            viewModel.chartType = ChartTypeHorizontalBars;
            viewModel.title = @"Rating";
            break;
        case 4:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store];
            viewModel.chartType = ChartTypePie;
            viewModel.title = @"Labels";
            break;

        default:
            break;
    }

    return viewModel;
}

@end
