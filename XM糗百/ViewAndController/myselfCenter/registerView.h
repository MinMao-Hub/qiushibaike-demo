//
//  registerView.h
//  task_0815
//
//  Created by  on 14-8-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface registerView : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>
{
    UIButton *borderdSelect;
    UIImageView *myNavBar;
    UILabel *textLabel;
    UIScrollView *_scrollViewForscroll;
}
//- (void)setRegisterButton;
- (void)setNavBar;
- (void)setViewForPersoner;
- (void)setProtocolLinkView;
@property (nonatomic,retain) UITextField *userNameTextFeild;
@property (nonatomic,retain) UITextField *passWordTextFeild;
@property (nonatomic,retain) UILabel *l1;
@property (nonatomic,retain) UILabel *l2;
@end
