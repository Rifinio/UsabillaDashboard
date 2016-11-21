//
//  EmojiView.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 21/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmojiView;

@protocol EmojiViewDelegate <NSObject>

- (void)emojiButtonSelected:(EmojiView *)emojiView;
- (void)emojiButtonDeselected:(EmojiView *)emojiView;

@end

@interface EmojiView : UIView

@property (nonatomic, weak) id <EmojiViewDelegate> delegate;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initForRating:(NSInteger)rating;

- (void)setHighlighted:(BOOL)highlighted;

@end
