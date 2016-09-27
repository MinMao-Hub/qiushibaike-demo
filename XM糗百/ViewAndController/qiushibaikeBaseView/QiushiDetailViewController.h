//
//  QiushiDetailViewController.h
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSShareViewController.h"
#import "myCell.h"
@interface QiushiDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
    UIImageView *myNavBar;
    UITableView *_tableView;
    UIImageView *_inputTextbackground;
    SHSShareViewController *shareView;
    UIView *tipView;
}
@property (nonatomic,retain)myCell *detailCell;
@property (nonatomic,strong)NSString *qiushiId;
- (void)setNavBar;
-(void)loadData;
@end
