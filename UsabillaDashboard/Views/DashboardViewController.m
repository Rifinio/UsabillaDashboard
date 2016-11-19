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
#import "ChartCollectionViewCell.h"
#import "ChartCellViewModel.h"


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

    _collectoinView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.collectoinView.dataSource = self;
    self.collectoinView.delegate = self;
    self.collectoinView.alwaysBounceVertical = YES;
    self.collectoinView.backgroundColor = [UIColor flatWhiteColor];
    [self.view addSubview:self.collectoinView];
    [self.collectoinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self.collectoinView registerClass:[ChartCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];


//    _activityIndicator = [[UIActivityIndicatorView alloc]
//                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//
//    self.activityIndicator.center = self.view.center;
//    [self.activityIndicator startAnimating];
//    [self.view addSubview:self.activityIndicator];

//
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
    ChartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
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
