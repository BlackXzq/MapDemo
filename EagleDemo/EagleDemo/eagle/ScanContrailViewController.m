//
//  ScanContrailViewController.m
//  EagleDemo
//
//  Created by Black on 2018/5/31.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "ScanContrailViewController.h"

@interface ScanContrailViewController ()<BMKMapViewDelegate, BTKTrackDelegate>
@property (nonatomic, strong) BMKMapView* mapView;
@end

@implementation ScanContrailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"轨迹查看";
    
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态为普通定位模式
    self.view = _mapView;
    
    BTKQueryTrackProcessOption *option = [[BTKQueryTrackProcessOption alloc] init];
    option.denoise = TRUE; //设置纠偏时是否需要去噪
    option.vacuate = true; //设置纠偏时是否需要抽稀
//    option.mapMatch = TRUE; // 设置纠偏时是否需要绑路
    option.radiusThreshold = 10;
    option.transportMode = 1; //轨迹对应的交通方式 DRIVING:1 驾车 RIDING:2 骑行 WALKING:3 步行
    // 构造请求对象
    BTKQueryTrackLatestPointRequest *request = [[BTKQueryTrackLatestPointRequest alloc] initWithEntityName:USERNAME processOption: option outputCootdType:BTK_COORDTYPE_BD09LL serviceID:serviceID tag:1];
    // 发起查询请求
    [[BTKTrackAction sharedInstance] queryTrackLatestPointWith:request delegate:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}

#pragma mark-  BTKTrackDelegate
/**
 上传开发者自定义轨迹点的回调方法
 
 @param response 上传结果
 */
-(void)onAddCustomTrackPoint:(NSData *)response {
    NSLog(@"XXOO: onAddCustomTrackPoint");
}

/**
 批量上传开发者自定义的轨迹点的回调方法
 
 @param response 上传结果
 */
-(void)onBatchAddCustomTrackPoint:(NSData *)response {
    NSLog(@"XXOO: onBatchAddCustomTrackPoint");
}

/**
 实时位置查询的回调方法
 
 @param response 查询结果
 */
-(void)onQueryTrackLatestPoint:(NSData *)response {
    NSLog(@"XXOO: onQueryTrackLatestPoint");
}

/**
 里程查询的回调方法
 
 @param response 查询结果
 */
-(void)onQueryTrackDistance:(NSData *)response {
    NSLog(@"XXOO: onQueryTrackDistance");
}

/**
 轨迹查询的回调方法
 
 @param response 查询结果
 */
-(void)onQueryHistoryTrack:(NSData *)response {
    NSLog(@"XXOO: onQueryHistoryTrack");
}

/**
 缓存查询的回调方法
 
 @param response 查询结果
 */
-(void)onQueryTrackCacheInfo:(NSData *)response {
    NSLog(@"XXOO: onQueryTrackCacheInfo");
}

/**
 清空缓存的回调方法
 
 @param response 清空操作的结果
 */
-(void)onClearTrackCache:(NSData *)response {
    NSLog(@"XXOO: onClearTrackCache");
}


@end
