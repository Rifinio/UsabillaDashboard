//
//  EmojiView.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 21/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "EmojiView.h"
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@interface EmojiView()

@property (nonatomic, strong) UIView *selectionView;
@property (nonatomic, strong) UIButton *emojiButton;

@end

@implementation EmojiView

#pragma mark init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isSelected = NO;

        self.backgroundColor = [UIColor clearColor];
        _selectionView = [UIView new];
        self.selectionView.backgroundColor = [UIColor clearColor];
        self.selectionView.layer.cornerRadius = 31.0f;
        [self addSubview:self.selectionView];
        [self.selectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.width.equalTo(@62);
        }];

        _emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.emojiButton.layer.cornerRadius = 28.0f;
        [self.selectionView addSubview:self.emojiButton];
        [self.emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.selectionView);
            make.height.width.equalTo(@56);
        }];

        [self.emojiButton addTarget:self action:@selector(emojiClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initForRating:(NSInteger)rating
{
    self = [self init];
    if (self) {
        _rating = rating;
        [self.emojiButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"face-%ld", rating]] forState:UIControlStateNormal];

    }
    return self;
}


#pragma mark button actions

- (void)emojiClicked:(UIButton *)button
{
    if (self.isSelected) {
        [self setHighlighted:NO];
        [self.delegate emojiButtonDeselected:self];
    } else {
        [self setHighlighted:YES];
        [self.delegate emojiButtonSelected:self];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    self.isSelected = highlighted;
    self.selectionView.backgroundColor = (highlighted) ? [UIColor flatNavyBlueColor] : [UIColor clearColor];
}

@end
