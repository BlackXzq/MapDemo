//
//  BKLocationServiceManager.m
//  EagleDemo
//
//  Created by Black on 2018/6/1.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "BKLocationServiceManager.h"

@interface BKLocationServiceManager()<BMKLocationAuthDelegate, BMKLocationManagerDelegate, BMKGeoFenceManagerDelegate>
@property (nonatomic, strong) BMKLocationManager *locationManager;
@property (nonatomic, strong) BMKGeoFenceManager *geoFenceManager;
@end

@implementation BKLocationServiceManager

+ (instancetype)shareManager {
    static BKLocationServiceManager *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[BKLocationServiceManager alloc] init];
    });
    return __instance;
}
//初始化定位服务

- (void)setupServiceInfo {
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:AK authDelegate:self];
}

//创建地图围栏
- (void)bk_creatGeoFence {
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(31.272657, 121.528776);
    [self.geoFenceManager addCircleRegionForMonitoringWithCenter:center radius:100 coorType:BMKLocationCoordinateTypeBMK09LL customID:USERID];
}
/*
 - (void)removeTheGeoFenceRegion:(BMKGeoFenceRegion *)region; //移除指定围栏
 - (void)removeGeoFenceRegionsWithCustomID:(NSString *)customID; //移除指定customID的围栏
 - (void)removeAllGeoFenceRegions;  //移除所有围栏
 */
- (void)bk_removeGeoFence {
    [self.geoFenceManager removeAllGeoFenceRegions];
}

- (BMKLocationManager*)locationManager {
    if (!_locationManager) {
        //初始化实例
        _locationManager = [[BMKLocationManager alloc] init];
        //设置delegate
        _locationManager.delegate = self;
        //设置返回位置的坐标系类型
        _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
        //设置距离过滤参数
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        //设置预期精度参数
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置应用位置类型
        _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        //设置是否自动停止位置更新
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        //设置是否允许后台定位
        _locationManager.allowsBackgroundLocationUpdates = YES;
        //设置位置获取超时时间
        _locationManager.locationTimeout = 10;
        //设置获取地址信息超时时间
        _locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}

- (BMKGeoFenceManager*)geoFenceManager {
    if (!_geoFenceManager) {
        _geoFenceManager = [[BMKGeoFenceManager alloc] init];
        _geoFenceManager.delegate = self;
        _geoFenceManager.activeAction = BMKGeoFenceActiveActionInside | BMKGeoFenceActiveActionOutside | BMKGeoFenceActiveActionStayed;
        //设置希望侦测的围栏触发行为，默认是侦测用户进入围栏的行为，即BMKGeoFenceActiveActionInside，这边设置为进入，离开，停留（在围栏内10分钟以上），都触发回调
        _geoFenceManager.allowsBackgroundLocationUpdates = YES;  //允许后台定位
    }
    return _geoFenceManager;
}
- (void)bk_startUpdatingLocation {
    //连续定位
//    [self.locationManager setLocatingWithReGeocode:YES];
//    [self.locationManager startUpdatingLocation];
    //单次定位
    [self.locationManager requestLocationWithReGeocode:true withNetworkState:true completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        if (error) {
            NSLog(@"XXOO locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        if (location) {
            ALERT([location.rgcData description]);
        }
        
    }];

}

- (void)bk_stopUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark- BMKGeoFenceManagerDelegate
/**
 * @brief 添加地理围栏完成后的回调，成功与失败都会调用
 * @param manager 地理围栏管理类
 * @param regions 成功添加的一个或多个地理围栏构成的数组
 * @param customID 用户执行添加围栏函数时传入的customID
 * @param error 添加失败的错误信息
 */
- (void)BMKGeoFenceManager:(BMKGeoFenceManager *)manager didAddRegionForMonitoringFinished:(NSArray <BMKGeoFenceRegion *> *)regions customID:(NSString *)customID error:(NSError *)error
{
    if (error)
    {
        NSLog(@"XXOO 创建围栏失败 = %@", error);
        ALERT(@"创建围栏失败");
    }
    else
    {
        NSLog(@"XXOO 创建围栏成功 %@ success", regions.firstObject.customID);
        ALERT(@"创建围栏成功");
    }
}


/**
 * @brief 地理围栏状态改变时回调，当围栏状态的值发生改变，定位失败都会调用
 * @param manager 地理围栏管理类
 * @param region 状态改变的地理围栏
 * @param customID 用户执行添加围栏函数时传入的customID
 * @param error 错误信息，如定位相关的错误
 */
- (void)BMKGeoFenceManager:(BMKGeoFenceManager *)manager didGeoFencesStatusChangedForRegion:(BMKGeoFenceRegion *)region customID:(NSString *)customID error:(NSError *)error {
    if (error) {
        NSLog(@"XXOO geofence error = %@", error);
    }
    else
    {
        NSLog(@"XXOO geofence %@ status = %ld", region.customID, region.fenceStatus);
        switch(region.fenceStatus)
        {
            case BMKGeoFenceRegionStatusInside:
                NSLog(@"XXOO 地理围栏状态：进入地理围栏");
                ALERT(@"进入地理围栏");
                break;
                
            case BMKGeoFenceRegionStatusStayed:
                NSLog(@"XXOO 地理围栏状态：停留在地理围栏");
                ALERT(@"停留在地理围栏");
                break;
                
            case BMKGeoFenceRegionStatusOutside:
                NSLog(@"XXOO 地理围栏状态：离开地理围栏");
                ALERT(@"离开地理围栏");
                break;
                
            default:
                NSLog(@"XXOO 地理围栏状态：围栏状态未知");
                ALERT(@"围栏状态未知");
                break;
        }
    }

}


#pragma mark- BMKLocationManagerDelegate

- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    if (error) {
        NSLog(@"XXOO locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    } if (location) {//得到定位信息，添加annotation
        if (location.location) {
            NSLog(@"XXOO LOC = %f : %f",location.location.coordinate.latitude, location.location.coordinate.longitude);
        }
        if (location.rgcData) {
            NSLog(@"XXOO rgc = %@",[location.rgcData description]);
        }
    }
}

#pragma mark- BMKLocationAuthDelegate
/**
 *@brief 返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKLocationAuthErrorCode
 */
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError {
    switch (iError) {
        case BMKLocationAuthErrorUnknown:
            NSLog(@"XXOO: 获取地图授权定位错误");
            break;
        case BMKLocationAuthErrorSuccess:
            NSLog(@"XXOO: 获取地图授权定位成功");
            break;
        case BMKLocationAuthErrorNetworkFailed:
            NSLog(@"XXOO: 获取地图授权定位 因网络鉴权失败");
            break;
        default:
            NSLog(@"XXOO: 获取地图授权定位  KEY非法鉴权失败");
            break;
    }
}

@end
