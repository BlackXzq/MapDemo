//
//  BKMapServiceManager.h
//  EagleDemo
//
//  Created by Black on 2018/6/5.
//  Copyright © 2018年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKMapServiceManager : NSObject

//初始化路径管理服务
+ (instancetype)shareManager;
//初始化鹰眼服务数据配置
- (void)setupServiceInfo;

@end
