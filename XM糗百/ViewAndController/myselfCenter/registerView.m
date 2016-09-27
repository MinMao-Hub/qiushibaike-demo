//
//  registerView.m
//  task_0815
//
//  Created by  on 14-8-24.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "registerView.h"
#import "loginView.h"
#import "webViewForProtocol.h"
#import "HMGLTransitionManager.h"
#import "Switch3DTransition.h"
#import "FlipTransition.h"
#import "UserInfoModel.h"
#import "UserDataManager.h"
@implementation registerView
@synthesize userNameTextFeild = _userNameTextFeild,passWordTextFeild = _passWordTextFeild;
@synthesize l1 = _l1,l2 = _l2;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        borderdSelect.selected = YES;
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
    //添加导航
    [self setNavBar];
    [self setViewForPersoner];
    [self setProtocolLinkView];
}
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
}
//设置导航栏
- (void)setNavBar
{
    //添加导航栏
    myNavBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, 64)];
    myNavBar.userInteractionEnabled = YES;
    myNavBar.image = [UIImage imageNamed:@"writeText_nav_bg"];
    myNavBar.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:myNavBar];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 140)/2, 20, 140, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"注册";
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
    
    //注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"register_button"] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.frame = CGRectMake(kScreemWidth - 50, 27, 45, 30);
    [registerButton addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:registerButton];
}
- (void)backHomeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)registerClick:(UIButton *)sender
{

    [self.view endEditing:YES];
    //注册
    if (![borderdSelect isSelected]) {
        UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"必须遵守糗事百科官方协议！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [warn show];
    }else{
        NSString *userName = _userNameTextFeild.text;
        NSString *passWord = _passWordTextFeild.text;
        if (userName.length == 0||passWord.length == 0){
            UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"用户名或密码不能为空!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warn show];
        }else{
            UserInfoModel *model = [[UserInfoModel alloc] init];
            model.userName = userName;
            model.passWord = passWord;
            model.hobby = @"暂未填写";
            model.age = @"暂未填写";
            model.signature = @"暂未填写";
            model.sexy = @"暂未填写";
            model.introduce = @"暂未填写";
            model.location = @"暂未填写";
            UIImage *image = [UIImage imageNamed:@"mySelf_headIcon.png"];
            NSData *imgData = UIImagePNGRepresentation(image);
            model.userIcon = imgData;
            if([[UserDataManager shareUserDataManager] findModifyUser:model.userName].count > 0)
            {
                UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该用户名已被注册!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [warn show];
            }else
            {
                [[UserDataManager shareUserDataManager] insertData:model];
                UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"注册成功，是否立即登录？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                [warn show];
            }
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex ==0)
    {
        
    }else
    {   //前往登录        
        NSString *userName = _userNameTextFeild.text;
        [[NSNotificationCenter defaultCenter] postNotificationName:kRegisterUserName object:userName];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void)setViewForPersoner
{
    _scrollViewForscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreemWidth, kScreemHeight-20)];
    _scrollViewForscroll.contentSize = CGSizeMake(kScreemWidth, kScreemHeight-20-44);
    _scrollViewForscroll.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_scrollViewForscroll];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreemWidth - 194)/2, 0, 194, 180)];
    imageView.image = [UIImage imageNamed:@"login_view_image"];
    [_scrollViewForscroll addSubview:imageView];
    
    UIImageView *userNameImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreemWidth - 260)/2, 185, 260, 40)];
    userNameImgView.userInteractionEnabled = YES;
    userNameImgView.image = [UIImage imageNamed:@"userName_image"];
    _userNameTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, 240, 26)];
    
    _userNameTextFeild.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextFeild.placeholder = @"UserName";
    _userNameTextFeild.returnKeyType = UIReturnKeyNext;
    _userNameTextFeild.delegate = self;
    _userNameTextFeild.clearButtonMode =UITextFieldViewModeWhileEditing;
    _userNameTextFeild.tag = 102;
    [userNameImgView addSubview:_userNameTextFeild];
    
    UIImageView *passWordImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreemWidth - 260)/2, 180+45, 260, 40)];
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
}

- (void)setProtocolLinkView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(72, 112+124+44,33, 16)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"同意";
    label.font = [UIFont systemFontOfSize:15.5f];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentLeft;
    [_scrollViewForscroll addSubview:label];
    
    //图片上再加一个按钮
    borderdSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    borderdSelect.frame = CGRectMake(47, 112+125+36, 30, 30);
    [borderdSelect setImage:[UIImage imageNamed:@"rectangle-12-copy-副本"] forState:UIControlStateNormal];
    [borderdSelect setImage:[UIImage imageNamed:@"rectangle-12-copy"] forState:UIControlStateSelected];
    [borderdSelect addTarget:self action:@selector(clickSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_scrollViewForscroll addSubview:borderdSelect];
    
    UIButton *OfficialProtocol = [UIButton buttonWithType:UIButtonTypeCustom];
    [OfficialProtocol setTitle:@"糗事百科官方协议" forState:UIControlStateNormal];
    [OfficialProtocol setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    OfficialProtocol.titleLabel.font = [UIFont systemFontOfSize:15.5];
    OfficialProtocol.frame = CGRectMake(105, 112+124+44, 135, 16);
    [OfficialProtocol setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [OfficialProtocol addTarget:self action:@selector(protocolAction) forControlEvents:UIControlEventTouchUpInside];
    [_scrollViewForscroll addSubview:OfficialProtocol];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(105, 112+138+44,125, 1)];
    label1.backgroundColor = [UIColor redColor];
    label1.font = [UIFont systemFontOfSize:15.5f];
    label1.textColor = [UIColor redColor];
    label1.textAlignment = NSTextAlignmentLeft;
    [_scrollViewForscroll addSubview:label1];
}
- (void)clickSelect:(UIButton *)btn
{
//    if ((++i) % 2 == 1) {
        borderdSelect.selected = !borderdSelect.selected;
//    }else{
//        
//    }
}
- (void)protocolAction
{
    //进入糗事百科官方协议界面(创建模态视图) -- 添加动画
    FlipTransition *animation = [[FlipTransition alloc] init];
    animation.transitionType = FlipTransitionLeft;
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    webViewForProtocol *webView = [[webViewForProtocol alloc] init];
    [[HMGLTransitionManager sharedTransitionManager] presentModalViewController:webView onViewController:self];
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
