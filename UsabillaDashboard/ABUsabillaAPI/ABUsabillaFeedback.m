//
//  ABUsabillaFeedback.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 20/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "ABUsabillaFeedback.h"
#import <ChameleonFramework/Chameleon.h>
#import "ABUsabillaFeedbackViewController.h"

@import FirebaseDatabase;


static NSInteger usabillaTag = 22888;

@interface ABUsabillaFeedback()

@property (nonatomic, strong) NSMutableArray *selectedViews;
@property (nonatomic, assign) NSInteger viewTag;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, weak) UIViewController *delegateViewController;

@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation ABUsabillaFeedback

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isFeedBackModeActivated = NO;
        _selectedViews = [NSMutableArray array];
        _viewTag = usabillaTag;

        // init FireBase reference
        _ref = [[FIRDatabase database] reference];

        // setup send button
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sendButton.backgroundColor = [UIColor flatGreenColor];
        [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sendButton setTitleColor:[UIColor flatGreenColorDark] forState:UIControlStateHighlighted];
        self.sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
        self.sendButton.tag = self.viewTag;
        [self.sendButton addTarget:self action:@selector(sendFeedBack:) forControlEvents:UIControlEventTouchUpInside];
        self.viewTag++;
    }
    return self;
}

- (void)sendFeedBack:(UIButton *)button
{
    ABUsabillaFeedbackViewController *feedbackVC = [ABUsabillaFeedbackViewController new];
    [self.delegateViewController presentViewController:feedbackVC animated:YES completion:nil];

    NSLog(@"send");
}

- (void)unHighlightViews
{
    if (!self.isFeedBackModeActivated) {
        return;
    }

    UIViewController *delegateVC = (UIViewController *)self.delegate;
    for (NSInteger i = usabillaTag; i< self.viewTag; i++) {
        UIView *view = [delegateVC.view viewWithTag:i];
        if (view) [view removeFromSuperview];
    }

    self.isFeedBackModeActivated = NO;
}

- (void)highlightViews
{
    if (self.isFeedBackModeActivated) {
        [self unHighlightViews];
        return;
    }

    _delegateViewController = (UIViewController *)self.delegate;
    self.isFeedBackModeActivated = YES;
    [self listSubviewsOfView:self.delegateViewController.view];

    // add send button to delegate view
    self.sendButton.frame = CGRectMake(0, self.delegateViewController.view.frame.size.height-60, self.delegateViewController.view.frame.size.width, 60);
    [self.delegateViewController.view addSubview:self.sendButton];
}

- (void)listSubviewsOfView:(UIView *)view
{
    // Get the subviews of the view
    NSArray *subviews = [view subviews];

    // Return if there are no subviews
    if ([subviews count] == 0) return; // COUNT CHECK LINE

    for (UIView *subview in subviews) {
        if ([self viewIsLookedFor:subview]) {
            [self setupViewLayers:subview];
        }

        // List the subviews of subview
        [self listSubviewsOfView:subview];
    }
}

- (BOOL)viewIsLookedFor:(UIView *)view
{
    for (Class class in self.classes) {
        if([view isKindOfClass:class]) {
            return YES;
        }
    }

    return NO;
}

- (void)setupViewLayers:(UIView *)view
{
    view.userInteractionEnabled = YES;
    // Add highlighting buttons on top of views
    UIButton *frameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    frameButton.tag = self.viewTag;
    self.viewTag++;
    frameButton.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    frameButton.backgroundColor = [UIColor colorWithRed:122/255. green:122/255. blue:122/255. alpha:.3];
    frameButton.layer.borderColor = [UIColor redColor].CGColor;
    frameButton.layer.borderWidth = 1.0f;
    [view addSubview:frameButton];

    [frameButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(UIView *)view
{
    UIViewController *delegateVC = (UIViewController *)self.delegate;
    NSLog(@"maine view: %@ | view description : %@",delegateVC.description, view.superview.description);
    view.backgroundColor = [UIColor colorWithRed:255/255. green:0/255. blue:0/255. alpha:.3];
}

#pragma mark send feedback to firebase database
- (void)sendFeedBack
{
    // static values to be filled later with correct data
    NSDictionary *viewsDict = @{@"viewcontroller":@"DashboardViewController",@"viewDescription":@"<UILabel: 0x7fc0e6501c00; frame = (20 10; 284 33); text = 'Browsers'; layer = <_UILabelLayer: 0x61800009bb70>>",@"frame":@"(20 10; 284 33)"};
    NSDictionary *feedBackDict = @{@"Rating":@5, @"Comment":@"my first feedback",@"views":viewsDict};
    [[self.ref child:@"Feedback"] setValue:feedBackDict];
}


#pragma class methods

+ (UIImage *)usabillaBarButtonImage
{
    return [[UIImage imageNamed:@"usbailla-button-logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
