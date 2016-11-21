//
//  EmojiView.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 21/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "EmojiView.h"
#import <Masonry/Masonry.h>

@interface EmojiView()

@property (nonatomic, strong) UIView *selectionView;
@property (nonatomic, strong) UIButton *emojiButton;
@end

@implementation EmojiView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _selectionView = [UIView new];
        self.selectionView.backgroundColor = [UIColor clearColor];
        self.selectionView.layer.cornerRadius = 35.0f;
        [self addSubview:self.selectionView];
        [self.selectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

        _emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.emojiButton.layer.cornerRadius = 28.0f;
        [self.selectionView addSubview:self.emojiButton];
        [self.emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.selectionView);
            make.height.width.equalTo(@56);
        }];
    }
    return self;
}

- (instancetype)initForRating:(NSInteger)rating
{
    self = [self init];
    if (self) {
        [self.emojiButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"face-%ld", rating]] forState:UIControlStateNormal];
    }
    return self;
}

@end
