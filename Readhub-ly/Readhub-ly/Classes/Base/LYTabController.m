//
//  LYTabController.m
//  Readhub-ly
//
//  Created by halohily on 2018/3/23.
//  Copyright © 2018年 halohily.com. All rights reserved.
//

#import "LYTabController.h"
#import "LYNavigationController.h"
#import "TopicsViewController.h"
#import "NewsViewController.h"
#import "ProfileViewController.h"

@interface LYTabController ()

@end

@implementation LYTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabbar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTabbar
{
    TopicsViewController *topicsVC = [[TopicsViewController alloc] init];
    [self addChildViewController:topicsVC image:[UIImage imageNamed:@"discover_18x24_"] selectedImage:[UIImage imageNamed:@"discover_pressed_18x24_"] title:@"话题"];
    
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    [self addChildViewController:newsVC image:[UIImage imageNamed:@"discover_18x24_"] selectedImage:[UIImage imageNamed:@"discover_pressed_18x24_"] title:@"新闻"];
    
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    [self addChildViewController:profileVC image:[UIImage imageNamed:@"discover_18x24_"] selectedImage:[UIImage imageNamed:@"discover_pressed_18x24_"] title:@"我"];
}

- (void)addChildViewController:(UIViewController *)controller image:(UIImage *)image selectedImage:(UIImage *)selectImage title:(NSString *)title
{
    LYNavigationController *nav = [[LYNavigationController alloc] initWithRootViewController:controller];
    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectImage];
    nav.tabBarItem.title = title;
    [self addChildViewController:nav];
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
