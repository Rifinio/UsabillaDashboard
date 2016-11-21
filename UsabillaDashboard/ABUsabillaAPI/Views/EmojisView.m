//
//  EmojisView.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 21/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "EmojisView.h"
#import "EmojiView.h"
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>

@implementation EmojisView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray<EmojiView *> *viewsArray = [NSMutableArray array];

        for (int i = 1; i <= 5; i++) {
            EmojiView *emojiView = [[EmojiView alloc] initForRating:i];
            [self addSubview:emojiView];
            [viewsArray addObject:emojiView];
            [emojiView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.equalTo(@66);
                make.top.equalTo(self);
            }];
        }

        self.layer.borderColor = [UIColor flatBlueColor].CGColor;
        self.layer.borderWidth = 0.5f;
        self.layer.cornerRadius = 3.0f;
        self.clipsToBounds = YES;

    CGFloat borderMargin = 10;
    [viewsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                     withFixedSpacing:1
                                          leadSpacing:borderMargin
                                          tailSpacing:borderMargin];

    }
    return self;
}
@end
