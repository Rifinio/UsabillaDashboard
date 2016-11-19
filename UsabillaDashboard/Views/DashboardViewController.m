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

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectoinView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectoinView.dataSource = self;
    self.collectoinView.delegate = self;
    self.collectoinView.alwaysBounceVertical = YES;
    self.collectoinView.backgroundColor = [UIColor flatWhiteColor];
    [self.view addSubview:self.collectoinView];
    
    [self.collectoinView registerClass:[ChartCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.collectoinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self bindViewModel];
}

- (void)bindViewModel
{
    self.navigationItem.title = [self.viewModel title];

    @weakify(self);
    [[[self.viewModel hasUpdatedContent]
     deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self);
         self.navigationItem.title = @"loaded";
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark collection view delegates

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    ChartCellViewModel *cvm = [ChartCellViewModel new];
    [cell setViewModel:cvm];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}

@end
