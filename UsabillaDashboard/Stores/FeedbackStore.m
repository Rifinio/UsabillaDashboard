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
    //https://api.myjson.com/bins/58cee
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

- (NSDictionary *)browsersDataDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    for (Feedback *feedback in self.feedBackList) {
        NSNumber *count = dict[feedback.browserName];
        if (count) {
            double countInt = count.doubleValue + 1;
            dict[feedback.browserName] = @(countInt);
        } else {
            dict[feedback.browserName] = @1.0;
        }
    }

    return [dict copy];
}

- (NSDictionary *)platformDataDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    for (Feedback *feedback in self.feedBackList) {
        NSNumber *count = dict[feedback.platform];
        if (count) {
            double countInt = count.doubleValue + 1;
            dict[feedback.platform] = @(countInt);
        } else {
            dict[feedback.platform] = @1.0;
        }
    }

    return [dict copy];
}

- (NSDictionary *)geoLocatoinDataDictionaryMaxEntries:(NSInteger)max
{
    NSAssert((max> 0 && max < 15) , @"Max entries should be between 0 and 15");

    int maxCount = 0;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (Feedback *feedback in self.feedBackList) {
        NSString *geoLocationStr = [feedback.geoLocation stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSNumber *count = dict[geoLocationStr];
        if (count) {
            double countInt = count.doubleValue + 1;
            dict[geoLocationStr] = @(countInt);
        } else {
            dict[geoLocationStr] = @1.0;
        }

        maxCount++;
        if (maxCount > max) {
            break;
        }
    }

    return [dict copy];
}

- (NSDictionary *)ratingDataDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    for (Feedback *feedback in self.feedBackList) {
        NSNumber *count = dict[@(feedback.rating)];
        if (count) {
            double countInt = count.doubleValue + 1;
            dict[@(feedback.rating)] = @(countInt);
        } else {
            dict[@(feedback.rating)] = @1.0;
        }
    }

    return [dict copy];
}


- (NSDictionary *)labelsDataDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    for (Feedback *feedback in self.feedBackList) {
        if (feedback.labels) {
            for (NSString *label in feedback.labels) {
                NSNumber *count = dict[label];
                if (count) {
                    double countInt = count.doubleValue + 1;
                    dict[label] = @(countInt);
                } else {
                    dict[label] = @1.0;
                }
            }
        }
    }

    return [dict copy];
}

@end
