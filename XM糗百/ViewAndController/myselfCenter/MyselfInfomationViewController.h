//
//  MyselfInfomationViewController.h
//  qiushibaikeProject
//
//  Created by  on 14-9-29.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModifyUserInformationView.h"
@interface MyselfInfomationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ModifyUserInformationViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *myNavBar;
    //头像
    UIImageView *headIcon;
    //昵称
    UILabel *_userNameLabel;
    //个性签名
    UILabel *signatureTextView;
    
    NSArray *_listArray1;
    NSArray *_listArray2;
    
    UITableView *_tableView;
    
    
    ModifyUserInformationView *modifyView;
}
@property (nonatomic,retain) UILabel *userNameLabel;
@property (nonatomic,strong) NSString *userNameForFront;
- (void)setNavBar;
- (void)setMyTableView;
- (void)setMyHeaderView;
- (void)setUserInfoFromCoreData;
@end
