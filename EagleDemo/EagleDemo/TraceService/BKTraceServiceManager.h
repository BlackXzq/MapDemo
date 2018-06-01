//
//  BKTraceServiceManager.h
//  EagleDemo
//
//  Created by Black on 2018/5/31.
//  Copyright © 2018年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduTraceSDK/BaiduTraceSDK.h>
#import "BKConstrants.h"

@interface BKTraceServiceManager : NSObject
// 是否启动服务上报轨 YES：当前服务已开启，正在上传；NO：当前服务未启动； default NO
@property (nonatomic, assign, readonly) BOOL isServiceStarted;

//初始化路径管理服务
+ (instancetype)shareManager;
//初始化鹰眼服务数据配置
- (void)setupServiceInfo;


//开始上传轨迹
- (void)startUploadContrail;

//结束上传轨迹
- (void)stopUploadContrail;
/**
 设置采集周期和打包上传的周期
 采集周期和上传周期的值域均为[2,300]，且上传周期必须是采集周期的整数倍
 
 @param gatherInterval 采集周期，单位：秒
 @param packInterval 打包上传周期，单位：秒

 */
-(void)changeGatherAndPackIntervals:(NSUInteger)gatherInterval packInterval:(NSUInteger)packInterval;


@end
