//
//  LocationViewController.m
//  EagleDemo
//
//  Created by Black on 2018/5/31.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "LocationViewController.h"
#import "BKLocationServiceManager.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"实时定位";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startLocation:(UIButton *)sender {
    [[BKLocationServiceManager shareManager] bk_startUpdatingLocation];
}
- (IBAction)stopLcation:(UIButton *)sender {
    [[BKLocationServiceManager shareManager] bk_stopUpdatingLocation];
}
- (IBAction)creatGeoFence:(UIButton *)sender {
    [[BKLocationServiceManager shareManager] bk_creatGeoFence];
}
- (IBAction)removeGeoFence:(UIButton *)sender {
    [[BKLocationServiceManager shareManager] bk_removeGeoFence];
}


@end
