//
//  Feedback.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feedback : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *browserName;

- (instancetype)initWithJsonDict:(NSDictionary *)dict;

@end
