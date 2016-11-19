//
//  DashboardViewModel.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "DashboardViewModel.h"
#import "FeedbackStore.h"


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


@end
