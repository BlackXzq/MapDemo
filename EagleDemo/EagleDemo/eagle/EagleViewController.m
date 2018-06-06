//
//  EagleViewController.m
//  EagleDemo
//
//  Created by Black on 2018/5/31.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "EagleViewController.h"
#import "ScanContrailViewController.h"
#import "ContrailViewController.h"
#import "BKTraceServiceManager.h"
#import "YYHistoryTrackViewController.h"

@interface EagleViewController ()

@end

@implementation EagleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"鹰眼追踪";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//  轨迹上报管理
- (IBAction)guijishangbao:(UIButton *)sender {
    ContrailViewController *contrailCtl = [[ContrailViewController alloc] init];
    contrailCtl.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:contrailCtl animated:true];
}
//  围栏设置
- (IBAction)weilanshezhi:(UIButton *)sender {
    YYHistoryTrackViewController *historyCtl = [[YYHistoryTrackViewController alloc] init];
    historyCtl.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:historyCtl animated:true];

}
//  轨迹查看
- (IBAction)guijichakan:(UIButton *)sender {
    YYHistoryTrackViewController *historyCtl = [[YYHistoryTrackViewController alloc] init];
    historyCtl.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:historyCtl animated:true];
    
//    ScanContrailViewController *scanCtl = [[ScanContrailViewController alloc] init];
//    scanCtl.hidesBottomBarWhenPushed = true;
//    [self.navigationController pushViewController:scanCtl animated:true];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
