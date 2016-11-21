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

@interface EmojisView() <EmojiViewDelegate>
@property (nonatomic, strong) NSMutableArray<EmojiView *> *viewsArray;
@end

@implementation EmojisView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _selectedRating = -1; // if user didn't select an emoji
        
        _viewsArray = [NSMutableArray array];

        for (int i = 1; i <= 5; i++) {
            EmojiView *emojiView = [[EmojiView alloc] initForRating:i];
            emojiView.delegate = self;
            [self addSubview:emojiView];
            [self.viewsArray addObject:emojiView];
            [emojiView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.equalTo(@66);
                make.top.equalTo(self);
            }];
        }

        CGFloat borderMargin = 10;
        [self.viewsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                         withFixedSpacing:1
                                              leadSpacing:borderMargin
                                          tailSpacing:borderMargin];
    }
    return self;
}

- (void)deselectAllEmojiesExceptOneWithRating:(NSInteger)rating
{
    for (EmojiView *emojiView in self.viewsArray) {
        if (emojiView.rating != rating) {
            [emojiView setHighlighted:NO];
        }
    }
}

#pragma mark emoji view delegates

-(void)emojiButtonSelected:(EmojiView *)emojiView
{
    self.selectedRating = emojiView.rating;
    [self deselectAllEmojiesExceptOneWithRating:self.selectedRating];
}

-(void)emojiButtonDeselected:(EmojiView *)emojiView
{
    self.selectedRating = -1;
}

@end
