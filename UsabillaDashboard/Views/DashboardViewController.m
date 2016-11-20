//
//  DashboardViewController.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "DashboardViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import <Masonry/Masonry.h>

#import "DashboardViewModel.h"
#import "ChartCellViewModel.h"

#import "ChartCollectionViewCell.h"
#import "PieChartCollectionViewCell.h"
#import "BarChartCollectionViewCell.h"
#import "HorizontalBarChartCollectionViewCell.h"


static NSString *baseCellId = @"baseCellId";
static NSString *pieChartCellId = @"pieChartCellId";
static NSString *barChartCellId = @"barChartCellId";
static NSString *HorizontalBarChartCellId = @"HorizontalBarChartCellId";

@interface DashboardViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong, readonly) DashboardViewModel *viewModel;
@property (nonatomic, strong) UICollectionView *collectoinView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation DashboardViewController

- (instancetype)initWithViewModel:(DashboardViewModel *)viewModel
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor flatRedColor];

    // set collection view
    _collectoinView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collectoinView.dataSource = self;
    self.collectoinView.delegate = self;
    self.collectoinView.backgroundColor = [UIColor flatWhiteColor];
    [self.view addSubview:self.collectoinView];
    [self.collectoinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    // register collection view cells
    [self.collectoinView registerClass:[ChartCollectionViewCell class] forCellWithReuseIdentifier:baseCellId];
    [self.collectoinView registerClass:[PieChartCollectionViewCell class] forCellWithReuseIdentifier:pieChartCellId];
    [self.collectoinView registerClass:[BarChartCollectionViewCell class] forCellWithReuseIdentifier:barChartCellId];
    [self.collectoinView registerClass:[HorizontalBarChartCollectionViewCell class] forCellWithReuseIdentifier:HorizontalBarChartCellId];

    // Activity indicator
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [self.activityIndicator startAnimating];

    [self bindViewModel];
}

- (void)bindViewModel
{
    self.navigationItem.title = [self.viewModel title];

    @weakify(self);
    [[self.viewModel.hasUpdatedContent
      deliverOnMainThread] // important, or view won't update instantly
     subscribeNext:^(id _) {
         @strongify(self); // this, together with @weakify, prevents a retain cycle
         [self.collectoinView reloadData];
         [self.activityIndicator stopAnimating];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark collection view delegates

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItems];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChartCollectionViewCell *cell;
    switch (indexPath.row) {
        case 0:
        case 4:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:pieChartCellId forIndexPath:indexPath];
            break;
        case 1:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:barChartCellId forIndexPath:indexPath];
            break;
        case 2:
        case 3:
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:HorizontalBarChartCellId forIndexPath:indexPath];
            break;
    }

    [cell setViewModel:[self.viewModel viewModelForCellAtIndex:indexPath]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected element at index : %ld", indexPath.row);
}

@end
