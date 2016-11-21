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
#import "EmojisView.h"

@interface ABUsabillaFeedbackViewController ()

@property (nonatomic, strong) EmojisView *emoView;
@property (nonatomic, strong) UITextView *textViewFeedBack;

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

    //Emojis View
    UILabel *labelWhatDoYouFeel = [UILabel new];
    labelWhatDoYouFeel.font = [UIFont systemFontOfSize:15.0f];
    labelWhatDoYouFeel.textColor = [UIColor flatNavyBlueColor];
    labelWhatDoYouFeel.text = @"How do you feel about that ?";
    [self.view addSubview:labelWhatDoYouFeel];
    [labelWhatDoYouFeel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(10, 10, 0, 10));
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.height.equalTo(@33);
    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor flatNavyBlueColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.top.equalTo(labelWhatDoYouFeel.mas_bottom);
        make.height.equalTo(@.3);
    }];

    _emoView = [EmojisView new];
    [self.view addSubview:self.emoView];
    [self.emoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.top.equalTo(labelWhatDoYouFeel.mas_bottom).offset(10);
        make.height.equalTo(@70);

    }];


    // TextField views
    UILabel *labelYourFeedBack = [UILabel new];
    labelYourFeedBack.font = [UIFont systemFontOfSize:15.0f];
    labelYourFeedBack.textColor = [UIColor flatNavyBlueColor];
    labelYourFeedBack.text = @"Tell us more";
    [self.view addSubview:labelYourFeedBack];
    [labelYourFeedBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(10, 10, 0, 10));
        make.top.equalTo(self.emoView.mas_bottom).offset(20);
        make.height.equalTo(@33);
    }];
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = [UIColor flatNavyBlueColor];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.top.equalTo(labelYourFeedBack.mas_bottom);
        make.height.equalTo(@.3);
    }];

    _textViewFeedBack = [UITextView new];
    self.textViewFeedBack.layer.borderColor = [UIColor flatNavyBlueColor].CGColor;
    self.textViewFeedBack.layer.borderWidth = 0.3f;
    self.textViewFeedBack.layer.cornerRadius = 3.0;
    self.textViewFeedBack.clipsToBounds = YES;
    [self.view addSubview:self.textViewFeedBack];

    // send and cancel buttons
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [cancelButton setTitleColor:[UIColor flatRedColorDark] forState:UIControlStateHighlighted];
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
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [sendButton setTitleColor:[UIColor flatGreenColorDark] forState:UIControlStateHighlighted];
    [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setBackgroundColor:[UIColor flatGreenColor]];
    [self.view addSubview:sendButton],
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.right.bottom.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX);
    }];

    [self.textViewFeedBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.top.equalTo(labelYourFeedBack.mas_bottom).offset(10);
        make.bottom.equalTo(sendButton.mas_top).offset(-10);
    }];
}

- (void)sendAction:(UIButton *)button
{
    NSMutableDictionary *feedBackDict = [NSMutableDictionary dictionary];
    feedBackDict[@"Rating"] = @(self.emoView.selectedRating);
    feedBackDict[@"Message"] = self.textViewFeedBack.text;
    [self.delagate usabillaViewController:self didSendFeedBack:[feedBackDict copy]];
}

- (void)cancelAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
