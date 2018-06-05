//
//  BKMapServiceManager.m
//  EagleDemo
//
//  Created by Black on 2018/6/5.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "BKMapServiceManager.h"

@implementation BKMapServiceManager {
    BMKMapManager* _mapManager;
}

+ (instancetype)shareManager {
    static BKMapServiceManager *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[BKMapServiceManager alloc] init];
    });
    return __instance;
}
//初始化定位服务

- (void)setupServiceInfo {
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:AK  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

@end
