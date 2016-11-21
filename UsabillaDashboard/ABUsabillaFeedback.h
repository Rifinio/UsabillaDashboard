//
//  ABUsabillaFeedback.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 20/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ABUsabillaFeedbackDelegate <NSObject>

@end

@interface ABUsabillaFeedback : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSArray<Class> *classes;
@property (nonatomic, assign) BOOL isFeedBackModeActivated;

- (void)highlightViews;

@end
