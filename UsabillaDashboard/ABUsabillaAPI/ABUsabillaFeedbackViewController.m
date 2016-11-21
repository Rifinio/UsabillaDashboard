//
//  ABUsabillaFeedbackViewController.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 21/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "ABUsabillaFeedbackViewController.h"
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>
#import "EmojiView.h"

@interface ABUsabillaFeedbackViewController ()

@end

@implementation ABUsabillaFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor flatWhiteColor];

    UIView *navigationView = [UIView new];
    navigationView.backgroundColor = [UIColor flatNavyBlueColor];
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@65);
    }];

    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"Feedback";
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    titleLabel.textColor = [UIColor flatWhiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navigationView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(navigationView);
        make.height.equalTo(@33);
        make.width.equalTo(@120);
        make.bottom.equalTo(navigationView).offset(-6);
    }];

    //emojis view
    UIView *emojisView = [UIView new];
    emojisView.backgroundColor = [UIColor flatOrangeColor];
    [self.view addSubview:emojisView];
    [emojisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.height.equalTo(@70);
    }];

//    CGFloat borderMargin = [UIDevice isIPad] ? 37 : 10;
//    [self.tierLevelViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
//                                     withFixedSpacing:1
//                                          leadSpacing:borderMargin
//                                          tailSpacing:borderMargin];

    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor flatRedColor]];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton],
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.left.bottom.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX);
    }];

    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setTitle:@"Send" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setBackgroundColor:[UIColor flatGreenColor]];
    [self.view addSubview:sendButton],
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.right.bottom.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX);
    }];
}

- (void)setupEmojisView
{
}

- (void)sendAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
