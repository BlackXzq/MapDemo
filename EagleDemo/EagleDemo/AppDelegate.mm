//
//  AppDelegate.m
//  EagleDemo
//
//  Created by Black on 2018/5/30.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "AppDelegate.h"
#import "LocationViewController.h"
#import "EagleViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootController];
    
    [self setConfigure];
    return YES;
}

- (void)setupRootController {
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    UITabBarController *rootTabar = [[UITabBarController alloc] init];
    LocationViewController *locationCtl = [[LocationViewController alloc] init];
    UINavigationController *locNavCtl = [self createContainTabarNavCtl:locationCtl
                                                              imgeName:@"location"
                                                        hightImageName:@"location_H"
                                                                 title:@"定位"];
    
    EagleViewController *eagleCtl = [[EagleViewController alloc] init];
    UINavigationController *eagleNavCtl = [self createContainTabarNavCtl:eagleCtl
                                                                imgeName:@"eagle"
                                                          hightImageName:@"eagle_H"
                                                                   title:@"鹰眼"];
    
    rootTabar.viewControllers = @[locNavCtl, eagleNavCtl];
    self.window.rootViewController = rootTabar;
    [self.window makeKeyAndVisible];
    rootTabar.selectedIndex = 1;
}

- (UINavigationController *)createContainTabarNavCtl:(UIViewController *)controller
                                            imgeName:(NSString *)imgeName
                                      hightImageName:(NSString *)hightImgName
                                               title:(NSString *)title {
    
    UINavigationController *navCtl = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [controller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:12.0f],NSFontAttributeName,nil]forState:UIControlStateSelected];
    controller.tabBarItem.title = title;
    UIImage *locationNoramlImg = [self reSizeImage:[UIImage imageNamed:imgeName] toSize:CGSizeMake(30, 30)];
    UIImage *locationHImg = [self reSizeImage:[UIImage imageNamed:hightImgName] toSize:CGSizeMake(30, 30)];
    controller.tabBarItem.image = [locationNoramlImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [locationHImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return navCtl;
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}


- (void)setConfigure {
    //  初始化鹰眼配置信息
    [[BKTraceServiceManager shareManager] setupServiceInfo];
    [[BKLocationServiceManager shareManager] setupServiceInfo];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
