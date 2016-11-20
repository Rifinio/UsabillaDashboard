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

- (instancetype)initWithStore:(FeedbackStore *)store kpi:(KPIType)kpiType
{
    self = [super init];
    if (self) {
        _store = store;
        NSDictionary *keyValues;
        switch (kpiType) {
            case KPIBrowser:
                keyValues = [self.store browsersDataDictionary];
                break;
            case KPIPlatform:
                keyValues = [self.store platformDataDictionary];
                break;
            case KPIGeolocation:
                keyValues = [self.store geoLocatoinDataDictionary];
                break;
            case KPIRating:
                keyValues = [self.store ratingDataDictionary];
                break;
            case KPILabel:
                keyValues = [self.store browsersDataDictionary];
                break;
            default:
                break;
        }

        NSLog(@"*** dict data ***\n%@", keyValues);
        _keyValues = @{@"keys":keyValues.allKeys, @"values":keyValues.allValues};
    }
    return self;
}

@end
