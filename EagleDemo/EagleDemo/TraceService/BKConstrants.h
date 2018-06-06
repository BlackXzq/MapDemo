//
//  BKConstrants.h
//  EagleDemo
//
//  Created by Black on 2018/5/30.
//  Copyright © 2018年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ALERT(msg) [[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define LATEST_LOCATION @"latest_location"
#define GLOBAL_QUEUE dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define MAIN_QUEUE dispatch_get_main_queue()

#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define CURRENT_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define ENTITY_NAME @"entity_name"
#define HISTORY_TRACK_START_TIME @"history_track_start_time"
#define HISTORY_TRACK_END_TIME @"history_track_end_time"

#define CURRENT_LOCALE [NSLocale currentLocale]
#define APP_DELEGATE [[UIApplication sharedApplication] delegate]


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

FOUNDATION_EXPORT CGFloat const kTableViewCellPickerViewHeight;

FOUNDATION_EXPORT CGFloat const kTableViewCellAnimationShowDuration;

FOUNDATION_EXPORT CGFloat const kTableViewCellAnimationHideDuration;

FOUNDATION_EXPORT CGFloat const kHeightForHeaderInSection;





@end
