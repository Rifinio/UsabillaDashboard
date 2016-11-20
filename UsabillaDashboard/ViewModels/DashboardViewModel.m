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
        _hasUpdatedContent = [[RACObserve(self, feedBackList) ignore:nil] mapReplace:@YES];
        RAC(self, feedBackList) = [self.store fetchFeedBack];
    }
    return self;
}

- (NSString *)title
{
    return @"Dashboard";
}

- (NSInteger)numberOfItems
{
    return (self.feedBackList) ? 5 : 0;
}

- (ChartCellViewModel *)viewModelForCellAtIndex:(NSIndexPath *)indexPath
{
    //Create custom view model for each cell
    ChartCellViewModel *viewModel;

    switch (indexPath.row) {
        case 0:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store kpi:KPIBrowser];
            viewModel.chartType = ChartTypePie;
            viewModel.title = @"Browsers";
            break;
        case 1:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store kpi:KPIPlatform];
            viewModel.chartType = ChartTypeVerticalBars;
            viewModel.title = @"Platforms";
            break;
        case 2:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store kpi:KPIGeolocation];
            viewModel.chartType = ChartTypeHorizontalBars;
            viewModel.title = @"Geolocations";
            break;
        case 3:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store kpi:KPIRating];
            viewModel.chartType = ChartTypeHorizontalBars;
            viewModel.title = @"Ratings";
            break;
        case 4:
            viewModel = [[ChartCellViewModel alloc] initWithStore:self.store kpi:KPILabel];
            viewModel.chartType = ChartTypePie;
            viewModel.title = @"Labels";
            break;

        default:
            break;
    }

    return viewModel;
}

@end
