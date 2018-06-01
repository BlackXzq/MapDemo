//
//  UserEntity.m
//  EagleDemo
//
//  Created by Black on 2018/5/31.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "UserEntity.h"
#import "BKConstrants.h"

@interface UserEntity()
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPhoneNum;
@end

@implementation UserEntity

+ (instancetype)defaultEntity {
    static UserEntity *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[UserEntity alloc] init];
    });
    return __instance;
}

- (void)creatDefautUserEntity {
    self.userID = USERID;
    self.userName = USERNAME;
    self.userPhoneNum = USERPHONENUM;
}


@end
