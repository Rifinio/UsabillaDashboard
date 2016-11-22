//
//  FeedbackTests.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 22/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "Feedback.h"

static NSString *dummyEmail = @"adil.bougamza@gmail.com";
static NSString *dummyLabel = @"Suggestion";
static NSString *dummyLocation = @"Netherlands";
static NSString *dummyBorwser = @"Chrome";
static NSString *dummyPlatform = @"MacOSX";
static NSInteger dummyRating = 5;


SPEC_BEGIN(FeedbackTests)

describe(@"Feedback", ^{
    context(@"When Feedback object is initilized", ^{
        NSDictionary *feedBackDict = @{@"rating": @(dummyRating),
                                       @"labels":@[dummyLabel],
                                       @"email":dummyEmail,
                                       @"computed_location":dummyLocation,
                                       @"computed_browser":@{@"Browser":dummyBorwser, @"Platform":dummyPlatform},
                                       };

        Feedback *feedback = [[Feedback alloc] initWithJsonDict:feedBackDict];

        it(@"should not be nil", ^{
            [[feedback shouldNot] beNil];
        });

        it(@"All values should match", ^{
            [[feedback.email should] equal:dummyEmail];
            [[feedback.geoLocation should] equal:dummyLocation];
            [[feedback.browserName should] equal:dummyBorwser];
            [[feedback.platform should] equal:dummyPlatform];
            [[theValue(feedback.rating) should] equal:@(dummyRating)];
            [[theValue(feedback.labels.count == @[dummyLabel].count) should] beTrue];
            [[feedback.labels should] containObjectsInArray:@[dummyLabel]];
        });
    });
});

SPEC_END
