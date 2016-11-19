//
//  NSURLSession+RAC.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NSURLSession (RAC)

- (RACSignal *)rac_GET:(NSURL *)url;

@end
