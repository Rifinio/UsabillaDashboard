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

@interface DashboardViewModel : NSObject

@property (nonatomic, readonly) RACSignal *hasUpdatedContent;

- (instancetype)initWithStore:(FeedbackStore *)feedbackStore;

- (NSString *)title;

@end
