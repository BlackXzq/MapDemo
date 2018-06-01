//
//  BKTraceServiceManager.m
//  EagleDemo
//
//  Created by Black on 2018/5/31.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "BKTraceServiceManager.h"

NSString * const SericeStatusKey = @"SericeStatusKey";

@interface BKTraceServiceManager()<BTKTraceDelegate>

@property (nonatomic, assign) BOOL isServiceStarted;

@end

@implementation BKTraceServiceManager

+ (instancetype)shareManager {
    static BKTraceServiceManager *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[BKTraceServiceManager alloc] init];
        [__instance getSericeStatusCache];
        if (__instance.isServiceStarted) {
            [__instance startUploadContrail];
        }
    });
    return __instance;
}

- (void)setupServiceInfo {
    // 设置鹰眼SDK的基础信息
    // 每次调用startService开启轨迹服务之前，可以重新设置这些信息。
    BTKServiceOption *basicInfoOption = [[BTKServiceOption alloc] initWithAK:AK mcode:MCODE serviceID:serviceID keepAlive:true];
    [[BTKAction sharedInstance] initInfo:basicInfoOption];
    [self changeGatherAndPackIntervals:GatherInterval packInterval:PackInterval];
}

- (void)startUploadContrail {
    BTKStartServiceOption *startServiceOption = [[BTKStartServiceOption alloc] initWithEntityName:USERNAME];
    dispatch_async(GLOBAL_QUEUE, ^{
        [[BTKAction sharedInstance] startService:startServiceOption delegate:self];
    });
}

- (void)stopUploadContrail {
    dispatch_async(GLOBAL_QUEUE, ^{
        [[BTKAction sharedInstance] stopGather:self];
    });
}

- (void)updateSericeCache {
    [[NSUserDefaults standardUserDefaults] setBool:self.isServiceStarted forKey:SericeStatusKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)getSericeStatusCache {
    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:SericeStatusKey];
    self.isServiceStarted = flag;
}

-(void)changeGatherAndPackIntervals:(NSUInteger)gatherInterval packInterval:(NSUInteger)packInterval {
    [[BTKAction sharedInstance] changeGatherAndPackIntervals:gatherInterval packInterval:packInterval delegate:self];
}

#pragma mark - BTKTraceDelegate
-(void)onStartService:(BTKServiceErrorCode)error {
    // 维护状态标志
    // 维护状态标志
    if (error == BTK_START_SERVICE_SUCCESS || error == BTK_START_SERVICE_SUCCESS_BUT_OFFLINE) {
        NSLog(@"XXOO轨迹服务开启成功");
        [[BTKAction sharedInstance] startGather:self];
        self.isServiceStarted = true;
        [self updateSericeCache];
    } else {
        NSLog(@"XXOO轨迹服务开启失败");
    }
}

-(void)onStopService:(BTKServiceErrorCode)error {
    // 维护状态标志
    if (error == BTK_STOP_SERVICE_NO_ERROR) {
        NSLog(@"XXOO轨迹服务停止成功");
        self.isServiceStarted = false;
        [self updateSericeCache];
    } else {
        NSLog(@"XXOO轨迹服务停止失败");
    }
}

-(void)onStartGather:(BTKGatherErrorCode)error {
    // 维护状态标志
    if (error == BTK_START_GATHER_SUCCESS) {
        NSLog(@"XXOO开始采集成功");
    } else {
        NSLog(@"XXOO开始采集失败");
    }
}

-(void)onStopGather:(BTKGatherErrorCode)error {
    // 维护状态标志
    if (error == BTK_STOP_GATHER_NO_ERROR) {
        NSLog(@"XXOO停止采集成功");
        [[BTKAction sharedInstance] stopService:self];
    } else {
        NSLog(@"XXOO停止采集失败");
    }
}

-(NSDictionary *)onGetCustomData {
    NSLog(@"XXOO onGetCustomData");
    NSMutableDictionary *customData = [NSMutableDictionary dictionary];
    customData[@"phoneNum"] = USERPHONENUM;
//    customData[@"entity_desc"] = USERID;
    return [NSDictionary dictionaryWithDictionary:customData];
}

/**
 收到推送消息的回调方法
 
 @param message 推送消息的内容
 */
-(void)onGetPushMessage:(BTKPushMessage *)message {
    // 不是地理围栏的报警，不解析
    
}
/**
 更改采集和打包上传周期的结果的回调方法
 
 @param error 更改周期的结果
 */
-(void)onChangeGatherAndPackIntervals:(BTKChangeIntervalErrorCode)error {
    if (error == BTK_CHANGE_INTERVAL_NO_ERROR) {
        NSLog(@"XXOO修改上传周期参数成功");
    } else {
        NSLog(@"XXOO修改上传周期参数失败");
    }
}


@end
