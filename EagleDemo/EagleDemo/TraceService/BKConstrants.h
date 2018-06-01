//
//  BKConstrants.h
//  EagleDemo
//
//  Created by Black on 2018/5/30.
//  Copyright © 2018年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GLOBAL_QUEUE dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define GatherInterval  10  //默认轨迹采集周期
#define PackInterval    30  //默认轨迹上传周期

@interface BKConstrants : NSObject

FOUNDATION_EXPORT NSString * const AK;

FOUNDATION_EXPORT NSString * const MCODE;

FOUNDATION_EXPORT NSUInteger const serviceID;

FOUNDATION_EXPORT NSString * const YYServiceOperationResultNotification;

FOUNDATION_EXPORT NSString * const USERID;
FOUNDATION_EXPORT NSString * const USERNAME;
FOUNDATION_EXPORT NSString * const USERPHONENUM;


@end
