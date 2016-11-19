//
//  DashboardViewController.m
//  UsabillaDashboard
//
//  Created by Adil BOUGAMZA on 19/11/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "DashboardViewController.h"
#import "DashboardViewModel.h"
#import <ChameleonFramework/Chameleon.h>

@interface DashboardViewController ()

@property (nonatomic,strong, readonly) DashboardViewModel *viewModel;

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
    self.navigationItem.title = @"Dashboard";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
