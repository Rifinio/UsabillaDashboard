//
//  DashboardViewController.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DashboardViewModel; // forward declaration

@interface DashboardViewController : UIViewController

- (instancetype)initWithViewModel:(DashboardViewModel *)viewModel;

@end
