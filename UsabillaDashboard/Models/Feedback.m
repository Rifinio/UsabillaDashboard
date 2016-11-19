//
//  Feedback.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "Feedback.h"

@implementation Feedback

- (instancetype)initWithJsonDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _browserName = dict[@"computed_browser"][@"Browser"];
        _email = (!dict[@"email"] || dict[@"email"] == nil ||  dict[@"email"] == [NSNull null]) ? @"" : dict[@"email"];
    }
    return self;
}

@end
