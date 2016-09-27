//
//  otherViewController.h
//  qiushibaikeProject
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface otherViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *myNavBar;
    UITableView *_tableView;
    
    NSArray *tableItemsArr;
}
- (void)setNavBar;
@end
