//
//  UserEntity.h
//  EagleDemo
//
//  Created by Black on 2018/5/31.
//  Copyright © 2018年 Black. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject

@property (nonatomic, strong, readonly) NSString *userID;
@property (nonatomic, strong, readonly) NSString *userName;
@property (nonatomic, strong, readonly) NSString *userPhoneNum;

+ (instancetype)defaultEntity;

@end
