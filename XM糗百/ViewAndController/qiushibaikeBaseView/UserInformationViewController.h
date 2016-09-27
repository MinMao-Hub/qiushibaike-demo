//
//  UserInformationViewController.h
//  qiushibaikeProject
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserQiushiCell.h"
@interface UserInformationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *myNavBar;
    UIImageView *myTabBar;
    
    UILabel *moveLabel;
    
    NSArray *_userQiushiArray;
}
@property(nonatomic,retain)NSString *userId;
@property(nonatomic,retain)UIView   *surperView;
- (void)setNavBar;
- (void)setTabBar;
-(void)setMainView;
-(void)loadData;
-(void)loadUserQiushiData;
- (void)setheadImageWithLabels;
@end
