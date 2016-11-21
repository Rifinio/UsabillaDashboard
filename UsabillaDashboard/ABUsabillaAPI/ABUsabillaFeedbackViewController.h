//
//  ABUsabillaFeedbackViewController.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 21/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABUsabillaFeedbackViewController;

@protocol ABUsabillaFeedbackViewControllerDelegate <NSObject>

- (void)usabillaViewController:(ABUsabillaFeedbackViewController *)viewController didSendFeedBack:(NSDictionary *)feedBackDict;
- (void)usabillaViewControllerDidCancel:(ABUsabillaFeedbackViewController *)viewController;

@end

@interface ABUsabillaFeedbackViewController : UIViewController

@property (nonatomic, weak) id <ABUsabillaFeedbackViewControllerDelegate> delagate;

@end
