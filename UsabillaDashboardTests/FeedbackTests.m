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

    let(feedBackJson, ^{
        NSDictionary *feedBackDict = @{@"rating": @(dummyRating),
                                       @"labels":@[dummyLabel],
                                       @"email":dummyEmail,
                                       @"computed_location":dummyLocation,
                                       @"computed_browser":@{@"Browser":dummyBorwser},
                                       @"computed_browser":@{@"Platform":dummyLocation}
                                       };
        return feedBackDict;
    });


    context(@"When Feedback object is initilized", ^{
        Feedback *feedback = [[Feedback alloc] initWithJsonDict:feedBackJson];

        it(@"should not be nil", ^{
            [[feedback shouldNot] beNil];
        });

    });


});

SPEC_END
