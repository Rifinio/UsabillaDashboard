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

@property (nonnull, strong) UIView *selectionView;

@end

@implementation EmojiView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _selectionView = [UIView new];
        self.selectionView.backgroundColor = [UIColor blueColor];
        self.selectionView.layer.cornerRadius = 35.0f;
        [self addSubview:self.selectionView];
        [self.selectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

//        UIImageView *imageView = [UIImageView new];

    }
    return self;
}

@end
