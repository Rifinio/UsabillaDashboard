//
//  ChartCellViewModel.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedbackStore;

typedef NS_ENUM(NSUInteger, ChartType) {
    ChartTypePie = 0,
    ChartTypeVerticalBars,
    ChartTypeHorizontalBars,
};

@interface ChartCellViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *keyValues;
@property (nonatomic, assign) ChartType chartType;

- (instancetype)initWithStore:(FeedbackStore *)store;

@end
