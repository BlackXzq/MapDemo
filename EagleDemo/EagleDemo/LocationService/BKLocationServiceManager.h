//
//  BKLocationServiceManager.h
//  EagleDemo
//
//  Created by Black on 2018/6/1.
//  Copyright © 2018年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BMKLocationkit/BMKLocationComponent.h>
#import <BMKLocationKit/BMKLocationAuth.h>
#import "BKConstrants.h"


@interface BKLocationServiceManager : NSObject

//初始化路径管理服务
+ (instancetype)shareManager;
//初始化鹰眼服务数据配置
- (void)setupServiceInfo;

/**
 *  @brief 开始连续定位。调用此方法会cancel掉所有的单次定位请求。
 */
- (void)bk_startUpdatingLocation;

/**
 *  @brief 停止连续定位。调用此方法会cancel掉所有的单次定位请求，可以用来取消单次定位。
 */
- (void)bk_stopUpdatingLocation;
/**
 * coordinate 围栏中心点
 * gfName： 围栏名称
 *  @brief 创建圆形围栏默认半径100m。
 */
- (void)bk_creatGeoFence:(CLLocationCoordinate2D)coordinate name:(NSString *)gfName;
- (void)bk_removeGeoFence;
@end
