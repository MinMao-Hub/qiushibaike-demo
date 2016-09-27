//
//  loginView.h
//  task_0815
//
//  Created by  on 14-8-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginView : UIViewController<UITextFieldDelegate>
{
    UIButton *login;
    UIImageView *myNavBar;
    UIScrollView *_scrollViewForscroll;
}
@property (nonatomic,retain) UITextField *userNameTextFeild;
@property (nonatomic,retain) UITextField *passWordTextFeild;

- (void)setViewForPersoner;
@property(nonatomic,retain)NSString *userNameText;
@end
