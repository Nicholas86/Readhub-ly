//
//  TopicsViewController.m
//  Readhub-ly
//
//  Created by 刘毅 on 2018/3/25.
//  Copyright © 2018年 halohily.com. All rights reserved.
//

#import "TopicsViewController.h"
#import "LYFetchDataManager.h"

@interface TopicsViewController ()

@end

@implementation TopicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LYFetchDataManager sharedInstance] readHubDataByType:ReadhubTopic lastCursor:nil success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"===fetch data failed===");
    }];
    [[LYFetchDataManager sharedInstance] readHubDetailByType:ReadhubTopic dataID:@"4djhWVo81n9" success:^(id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"===fetch data failed===");
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.title = @"话题";
}

@end
