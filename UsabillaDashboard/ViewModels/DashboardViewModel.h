//
//  DashboardViewModel.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class FeedbackStore;
@class ChartCellViewModel;

@interface DashboardViewModel : NSObject

@property (nonatomic, readonly) RACSignal *hasUpdatedContent;

- (instancetype)initWithStore:(FeedbackStore *)feedbackStore;

- (NSString *)title;
- (NSInteger)numberOfItems;
- (ChartCellViewModel *)viewModelForCellAtIndex:(NSIndexPath *)indexPath;

@end
