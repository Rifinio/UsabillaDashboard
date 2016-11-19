//
//  FeedbackStore.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@class Feedback;

@interface FeedbackStore : NSObject


@property (nonatomic, strong) NSArray<Feedback *> *feedBackList;

- (RACSignal *)fetchFeedBack;
- (NSDictionary *)browsersDataDictionary;

@end
