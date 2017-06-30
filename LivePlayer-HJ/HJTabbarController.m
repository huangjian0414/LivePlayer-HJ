//
//  HJTabbarController.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJTabbarController.h"
#import "HJNaviController.h"
#import "HJGameViewController.h"
#import "HJLiveViewController.h"
#import "ViewController.h"
@interface HJTabbarController ()

@end

@implementation HJTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewController];
}

-(void)setUpChildViewController
{
    ViewController *home=[[ViewController alloc]init];
    [self setOneChildController:home title:@"首页" nomarlImage:@"tabbar_home" selectedImage:@"tabbar_home_sel"];
    HJLiveViewController *liveVC = [[HJLiveViewController alloc]init];
    [self setOneChildController:liveVC title:@"直播" nomarlImage:@"tabbar_room" selectedImage:@"tabbar_room_sel"];
    HJGameViewController *gameVC = [[HJGameViewController alloc]init];
    [self setOneChildController:gameVC title:@"游戏" nomarlImage:@"tabbar_game" selectedImage:@"tabbar_game_sel"];
    UIViewController *mineVC = [[UIViewController alloc]init];
    mineVC.view.backgroundColor=[UIColor blueColor];
    [self setOneChildController:mineVC title:@"我的" nomarlImage:@"tabbar_me" selectedImage:@"tabbar_me_sel"];
}

- (void)setOneChildController:(UIViewController *)vc title:(NSString *)title nomarlImage:(NSString *)nomarlImage selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:nomarlImage];
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];
    vc.title=title;
    HJNaviController *navVc=[[HJNaviController alloc]initWithRootViewController:vc];
    [self addChildViewController:navVc];
}


@end
