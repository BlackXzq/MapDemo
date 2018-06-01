//
//  ContrailViewController.m
//  EagleDemo
//
//  Created by Black on 2018/5/31.
//  Copyright © 2018年 Black. All rights reserved.
//

#import "ContrailViewController.h"
#import "BKTraceServiceManager.h"
@interface ContrailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startTransBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopTransBtn;

@end

@implementation ContrailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"轨迹管理";
    [self resfreshBtnState];
}

- (void)resfreshBtnState {
    self.startTransBtn.enabled = ![BKTraceServiceManager shareManager].isServiceStarted;
    self.stopTransBtn.enabled = [BKTraceServiceManager shareManager].isServiceStarted;
}
//开始发运上传轨迹
- (IBAction)startTransfer:(UIButton *)sender {
    [[BKTraceServiceManager shareManager] startUploadContrail];
    [self resfreshBtnState];
}
//完成运单，结束上传轨迹
- (IBAction)finishTransfer:(UIButton *)sender {
    [[BKTraceServiceManager shareManager] stopUploadContrail];
    [self resfreshBtnState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
