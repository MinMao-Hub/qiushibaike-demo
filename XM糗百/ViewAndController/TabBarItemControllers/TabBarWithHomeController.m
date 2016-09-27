//
//  TabBarWithHomeController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "TabBarWithHomeController.h"
#import "MianViewController.h"
#import "MessageViewController.h"
#import "UserCenterViewController.h"
#import "SettingViewController.h"
#import "otherViewController.h"
@implementation TabBarWithHomeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBar.backgroundImage = [UIImage imageNamed:@"writeText_nav_bg"];//writeText_nav_bg  tab_bg
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadViewControllers];
}
//装载视图控制器
- (void)loadViewControllers
{
    /*
     1.创建若干个子视图控制器（他们是并列关系）
     1.1 创建UIBarButtonItem的实例，赋值给相应的子视图控制器（有可能是导航控制器）
     2.创建一个数组，将已经创建的子视图控制器添加到数组中
     3.创建UITabBarController实例
     4.mainViewController.viewControllers = viewItems;把数组添加到UITabBarController中
     5.把UITabBarController的实例添加到window的rootViewCotroller中
     */
    
    //首页
    MianViewController *view1 = [[MianViewController alloc] init];
    //添加导航栏实现集成
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"首页" image: [UIImage imageNamed:@"1"]tag:1];
    view1.tabBarItem = homeItem;
    
    //小纸条页面
    MessageViewController *view2 = [[MessageViewController alloc] init];
    UITabBarItem *messageItem = [[UITabBarItem alloc] initWithTitle:@"小纸条" image: [UIImage imageNamed:@"4"]tag:2];
    view2.tabBarItem = messageItem;
    
    //个人中心页面
    
    UserCenterViewController *view3 = [[UserCenterViewController alloc] init];
    UITabBarItem *searchitem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[UIImage imageNamed:@"2"] tag:3];
    view3.tabBarItem = searchitem;
    
    //设置页面
    SettingViewController *view4 = [[SettingViewController alloc] init];
    //添加自定义图片
    UITabBarItem *settingItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"setting"] tag:4];
    view4.tabBarItem = settingItem;
    
    //其他页面
    otherViewController *view5 = [[otherViewController alloc] init];
    UITabBarItem *otherItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:[UIImage imageNamed:@"5"] tag:5];
    view5.tabBarItem = otherItem;
    
    NSArray *viewItems = [NSArray arrayWithObjects:view1,view2,view3,view4,view5,nil];
    [self setViewControllers:viewItems animated:YES];
}
@end
