//
//  ChartCollectionViewCell.h
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Charts/Charts-Swift.h>
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ChameleonFramework/Chameleon.h>

@class ChartCellViewModel;

@interface ChartCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ChartCellViewModel *viewModel;
@property (nonatomic, strong) UIView *chartView;

@end
