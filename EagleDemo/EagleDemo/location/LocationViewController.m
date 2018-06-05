//
//  LocationViewController.m
//  EagleDemo
//
//  Created by Black on 2018/5/31.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "LocationViewController.h"
#import "BKLocationServiceManager.h"
#import "EagleDemo-Swift.h"

@interface LocationViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate>
@property (nonatomic, strong) BMKMapView* mapView;
@property (nonatomic, strong) BMKLocationService* locService;
@property (nonatomic, assign) BOOL firstShowMe;
@property (nonatomic, assign) NSInteger num;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"实时定位";
    self.firstShowMe = true;
    self.num = 1;
    
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 170, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-170-54)];
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态为普通定位模式
    [_mapView setZoomLevel:14.5];
    [self.view addSubview:_mapView];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
}



- (IBAction)startLocation:(UIButton *)sender {
    [[BKLocationServiceManager shareManager] bk_startUpdatingLocation];
}
- (IBAction)stopLcation:(UIButton *)sender {
    [[BKLocationServiceManager shareManager] bk_stopUpdatingLocation];
}
- (IBAction)creatGeoFence:(UIButton *)sender {
//    [[BKLocationServiceManager shareManager] bk_creatGeoFence];
}
- (IBAction)removeGeoFence:(UIButton *)sender {
    [[BKLocationServiceManager shareManager] bk_removeGeoFence];
}

#pragma mark- BMKLocationServiceDelegate
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    //    NSLog(@"XXOO heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation; {
    NSLog(@"XXOO didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    if (self.firstShowMe) {
        [_mapView setCenterCoordinate:userLocation.location.coordinate animated:NO];
        self.firstShowMe = false;
    }
}


#pragma mark- BMKMapViewDelegate
/**
 *点中底图空白处会回调此接口
 *@param mapView 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"XXOO onClickedMapBlank latitude: %lf longitude: %lf", coordinate.latitude, coordinate.longitude);
}

/**
 *长按地图时会回调此接口
 *@param mapView 地图View
 *@param coordinate 返回长按事件坐标点的经纬度
 */
- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"XXOO onLongClick latitude: %lf longitude: %lf", coordinate.latitude, coordinate.longitude);
    NSString *make = [NSString stringWithFormat:@"围栏 %ld", self.num];
    [AJAlterView showTwoActionWithTitle:nil message:@"确认添加围栏吗" target:self confirmTitle:@"确认" cacelTitle:@"取消" confirmHandler:^(UIAlertAction * action) {
        [[BKLocationServiceManager shareManager] bk_creatGeoFence:coordinate name:make];
    } cancelHandler:^(UIAlertAction * action)  {
        NSLog(@"XXOO quxiao");
    }];
    self.num ++;
}

@end
