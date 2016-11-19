//
//  ChartCellViewModel.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "ChartCellViewModel.h"
#import "FeedbackStore.h"

@interface ChartCellViewModel()

@property (nonatomic, weak) FeedbackStore *store;

@end

@implementation ChartCellViewModel

- (instancetype)initWithStore:(FeedbackStore *)store
{
    self = [super init];
    if (self) {
        _store = store;
        NSDictionary *browserData = [self.store browsersDataDictionary];
        NSLog(@"*** Browser data ***\n%@", browserData);

//        NSArray *keys = @[@"Jan",@"feb", @"mar", @"apr", @"mai"];
//        NSArray *values = @[@(2000.0), @(1000.0), @(3000.0), @(1500.0), @(2500.0)];
        _keyValues = @{@"keys":browserData.allKeys, @"values":browserData.allValues};
    }
    return self;
}

@end
