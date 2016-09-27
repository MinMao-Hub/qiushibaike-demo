//
//  MianViewController.h
//  qiushibaikeProject
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "QiushiDetailViewController.h"
#import "PullTableView.h"
@interface MianViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIAlertViewDelegate,PullTableViewDelegate>
{
    UIView *view;
    UIImageView *myNavBar;
    UIScrollView *_scrollView;
    UIImageView *kindOfTabBar;

    UIImageView *_selectView;
    UILabel *MoveLabel;
    
}
@property (nonatomic,retain) QiushiDetailViewController  *detail;
@property (nonatomic,retain) UIImage *image;  
- (void)setNavBar;
- (void)setKindOfTabBar;
- (void)setScrollView;
- (void)loadData:(NSString *)urlString tableViewWithTag:(int)Tag;
@end
