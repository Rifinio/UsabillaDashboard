//
//  ChartCellViewModel.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "ChartCellViewModel.h"
#import "FeedbackStore.h"

@implementation ChartCellViewModel

- (instancetype)initWithStore:(FeedbackStore *)store
{
    self = [super init];
    if (self) {
        NSArray *keys = @[@"Jan",@"feb", @"mar", @"apr", @"mai"];
        NSArray *values = @[@(2000.0), @(1000.0), @(3000.0), @(1500.0), @(2500.0)];
        _keyValues = @{@"keys":keys, @"values":values};
    }
    return self;
}

@end
