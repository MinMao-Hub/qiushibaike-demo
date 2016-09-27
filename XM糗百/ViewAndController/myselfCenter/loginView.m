//
//  loginView.m
//  task_0815
//
//  Created by  on 14-8-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "loginView.h"
#import "registerView.h"
#import "UserInfoModel.h"
#import "UserDataManager.h"
#import "UserCenterViewController.h"
@implementation loginView
@synthesize userNameTextFeild = _userNameTextFeild,passWordTextFeild = _passWordTextFeild;
@synthesize userNameText = _userNameText;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundColor_login"]]];
    self.view = view;
    //添加导航栏
    myNavBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, 64)];
    myNavBar.userInteractionEnabled = YES;
    myNavBar.image = [UIImage imageNamed:@"writeText_nav_bg"];
    myNavBar.backgroundColor = [UIColor purpleColor];
    [view addSubview:myNavBar];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 140, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"登录";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:25.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavBar addSubview:titleLabel];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5, 27, 40, 30);
    [backButton addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:backButton];
    [self setViewForPersoner];
    
}
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
}
- (void)backHomeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setViewForPersoner
{
    _scrollViewForscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreemWidth, kScreemHeight-20)];
    _scrollViewForscroll.contentSize = CGSizeMake(kScreemWidth, kScreemHeight-20-44);
    _scrollViewForscroll.showsHorizontalScrollIndicator = NO;
    _scrollViewForscroll.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_scrollViewForscroll];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 194)/2, 0, 194, 180)];
    imageView.image = [UIImage imageNamed:@"login_view_image"];
    [_scrollViewForscroll addSubview:imageView];
    
    UIImageView *userNameImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 260)/2, 185, 260, 40)];
    userNameImgView.userInteractionEnabled = YES;
    userNameImgView.image = [UIImage imageNamed:@"userName_image"];
    _userNameTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, 240, 26)];
    
    _userNameTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextFeild.placeholder = @"UserName";
    _userNameTextFeild.text = self.userNameText;
    _userNameTextFeild.returnKeyType = UIReturnKeyNext;
    _userNameTextFeild.delegate = self;
    _userNameTextFeild.tag = 102;
    _userNameTextFeild.clearButtonMode =UITextFieldViewModeWhileEditing;
    [userNameImgView addSubview:_userNameTextFeild];
    
    UIImageView *passWordImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 260)/2, 180+45, 260, 40)];
    passWordImgView.userInteractionEnabled = YES;
    passWordImgView.image = [UIImage imageNamed:@"passWord_image"];
    _passWordTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, 240, 26)];
    _passWordTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTextFeild.placeholder = @"PassWord";
    _passWordTextFeild.secureTextEntry = YES;
    _passWordTextFeild.returnKeyType = UIReturnKeyDone;
    _passWordTextFeild.delegate = self;
    _passWordTextFeild.clearButtonMode =UITextFieldViewModeWhileEditing;
    _passWordTextFeild.tag = 101;
    [passWordImgView addSubview:_passWordTextFeild];
    
    [_scrollViewForscroll addSubview:userNameImgView];
    [_scrollViewForscroll addSubview:passWordImgView];
    
    login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake((self.view.frame.size.width - 260)/2, 180+35+35+30, 260, 40);
    login.tintColor = [UIColor redColor];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [login setBackgroundImage:[UIImage imageNamed:@"login_image"] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [_scrollViewForscroll addSubview:login];
}
- (void)clickLogin
{
    
    NSString *userName =_userNameTextFeild.text;
    NSString *passWord =_passWordTextFeild.text;
    if (userName.length == 0||passWord.length == 0){
        UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名或密码不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warn show];
    }else
    {
        UserInfoModel *model = [[UserInfoModel alloc] init];
        model.userName = userName;
        model.passWord = passWord;
        if([[UserDataManager shareUserDataManager] findData:model])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLoginState" object:_userNameTextFeild.text];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名或密码错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warn show];
        }
    }
    [self.view endEditing:YES];
}
#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == [self.view viewWithTag:102]) {
        UITextField *textField1 = (UITextField *)[self.view viewWithTag:101];
        [textField1 becomeFirstResponder];
        return YES;
    }else{
        [textField resignFirstResponder];
        [UIView beginAnimations:@"Animation" context:@"textField"];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        _scrollViewForscroll.contentSize = CGSizeMake(kScreemWidth, kScreemHeight-20-44);
        [_scrollViewForscroll setContentOffset:CGPointMake(0, 0) animated:YES];
        [UIView commitAnimations];
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"Animation" context:@"textField"];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    //让输入框和登录按钮滑动上去
    _scrollViewForscroll.contentSize = CGSizeMake(kScreemWidth, kScreemHeight-20-44+210);
    [_scrollViewForscroll setContentOffset:CGPointMake(0, 180-55) animated:YES];
    [UIView commitAnimations];
    
}
@end
