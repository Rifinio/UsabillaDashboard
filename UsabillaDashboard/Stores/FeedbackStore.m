//
//  FeedbackStore.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "FeedbackStore.h"
#import "NSURLSession+RAC.h"
#import "Feedback.h"

@implementation FeedbackStore

- (RACSignal *)fetchFeedBack
{
    NSURL *url = [NSURL URLWithString:@"http://localhost:8888/usabilla/usabilla-ws.json"];

    return [[[NSURLSession sharedSession] rac_GET:url]
            map:^(RACTuple *tuple) {
                NSData *data = tuple.first;

                NSDictionary *feedBackDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

                NSMutableArray *feedbackList = [NSMutableArray array];
                for (NSDictionary *dict in feedBackDictionary[@"items"]) {
                    Feedback *feedback = [[Feedback alloc] initWithJsonDict:dict];
                    NSLog(@"browser : %@ | email : %@", feedback.browserName, feedback.email);
                    [feedbackList addObject:feedback];
                }

                self.feedBackList = [feedbackList copy];
                return self.feedBackList;
            }];
}

@end
