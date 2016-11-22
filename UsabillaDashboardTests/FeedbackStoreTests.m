//
//  FeedbackStoreTests.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 22/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <OCMock/OCMock.h>
#import "FeedbackStore.h"

SPEC_BEGIN(FeedbackStoreTests)

describe(@"FeedbackStore", ^{

    let(feedbackStore, ^FeedbackStore*{
        FeedbackStore *fbStore = [FeedbackStore new];
        return fbStore;
    });

    context(@"When store is initilized", ^{

        it(@"should not be nill", ^{
            [[feedbackStore shouldNot] beNil];
        });
    });
});

SPEC_END
