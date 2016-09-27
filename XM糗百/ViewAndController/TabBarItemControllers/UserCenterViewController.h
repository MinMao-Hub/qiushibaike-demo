//
//  UserCenterViewController.h
//  qiushibaikeProject
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *myNavBar;
    UITableView *_tableView;
}
- (void)setNavBar;
@property BOOL isLogin;
@property (nonatomic,retain) NSString *loginedUserName;
@end
