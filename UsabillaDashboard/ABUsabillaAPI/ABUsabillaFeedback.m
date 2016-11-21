//
//  ABUsabillaFeedback.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 20/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "ABUsabillaFeedback.h"
#import <ChameleonFramework/Chameleon.h>

static NSInteger usabillaTag = 22888;

@interface ABUsabillaFeedback()

@property (nonatomic, strong) NSMutableArray *selectedViews;
@property (nonatomic, assign) NSInteger viewTag;
@property (nonatomic, strong) UIButton *sendButton;
@end

@implementation ABUsabillaFeedback

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isFeedBackModeActivated = NO;
        _selectedViews = [NSMutableArray array];
        _viewTag = usabillaTag;

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

    UIViewController *delegateVC = (UIViewController *)self.delegate;
    self.isFeedBackModeActivated = YES;
    [self listSubviewsOfView:delegateVC.view];

    // add send button to delegate view
    self.sendButton.frame = CGRectMake(0, delegateVC.view.frame.size.height-60, delegateVC.view.frame.size.width, 60);
    [delegateVC.view addSubview:self.sendButton];
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

#pragma class methods

+ (UIImage *)usabillaBarButtonImage
{
    return [[UIImage imageNamed:@"usbailla-button-logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
