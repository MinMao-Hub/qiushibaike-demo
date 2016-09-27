//
//  webViewForProtocol.m
//  qiushibaikeProject
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "webViewForProtocol.h"
#import "HMGLTransitionManager.h"
#import "FlipTransition.h"
@implementation webViewForProtocol

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
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setNavBar];
    
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 370, kScreemHeight-20-44-44)];
    [webView setUserInteractionEnabled:YES];
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.directionalLockEnabled = NO;
    NSURL *url = [NSURL URLWithString:@"http://about.qiushibaike.com/policy.html"];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    [webView loadRequest:request];
    
    if ([[webView subviews] count] > 0) {   // hide the shadows 
        for (UIView* shadowView in [[[webView subviews] objectAtIndex:0] subviews]) 
            {     
                [shadowView setHidden:YES];   
            }   // show the content  
            
        [[[[[webView subviews] objectAtIndex:0] subviews] lastObject] setHidden:NO]; 
    } 
    webView.backgroundColor = [UIColor whiteColor];
    webView.autoresizesSubviews = YES;//自动调整大小
    webView.scalesPageToFit = YES; //自动对页面进行缩放以适应屏幕
    
    [self.view addSubview:webView];
    
    [self setTabBar];
    //添加左滑手势
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backForwardView:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [webView addGestureRecognizer:rightSwipe];
}
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
}
- (void)backForwardView:(UISwipeGestureRecognizer *)swipe
{
    [webView goBack];
}
//设置导航栏
- (void)setNavBar
{
    //添加导航栏
    myNavBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, 64)];
    myNavBar.userInteractionEnabled = YES;
    myNavBar.image = [UIImage imageNamed:@"writeText_nav_bg"];
    [self.view addSubview:myNavBar];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 180)/2, 20, 180, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"糗事百科官方协议";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavBar addSubview:titleLabel];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5, 27, 40, 30);
    [backButton addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:backButton];
    
}
- (void)setTabBar
{
    //添加TabBar
    myTabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreemHeight-44, kScreemWidth, 44)];
    myTabBar.userInteractionEnabled = YES;
    myTabBar.image = [UIImage imageNamed:@"writeText_nav_bg"];
    [self.view addSubview:myTabBar];
    
    //确定（tabbar）
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"register_button"] forState:UIControlStateNormal];
    [registerButton setTitle:@"确定" forState:UIControlStateNormal];
    registerButton.frame = CGRectMake(120, 7, 80, 30);
    [registerButton addTarget:self action:@selector(agreeClick) forControlEvents:UIControlEventTouchUpInside];
    [myTabBar addSubview:registerButton];
}

- (void)backHomeAction:(UIButton *)sender
{
    FlipTransition *animation = [[FlipTransition alloc] init];
    animation.transitionType = FlipTransitionRight;
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    [[HMGLTransitionManager sharedTransitionManager] dismissModalViewController:self];
}
- (void)agreeClick
{
    FlipTransition *animation = [[FlipTransition alloc] init];
    animation.transitionType = FlipTransitionRight;
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    [[HMGLTransitionManager sharedTransitionManager] dismissModalViewController:self];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end










/*
 
 //拨打电话
 //确定（tabbar）
 UIButton *toCall = [UIButton buttonWithType:UIButtonTypeCustom];
 [toCall setBackgroundImage:[UIImage imageNamed:@"register_button"] forState:UIControlStateNormal];
 [toCall setTitle:@"客服" forState:UIControlStateNormal];
 toCall.frame = CGRectMake(220, 7, 80, 30);
 [toCall addTarget:self action:@selector(toCallAction) forControlEvents:UIControlEventTouchUpInside];
 [myTabBar addSubview:toCall];
 
 - (void)toCallAction
 {
 @try {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"在线咨询" message:@"确定拨打131-3579-5795电话咨询" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
 alert.tag = 666;
 [alert show];
 }
 @catch (NSException *exception) {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"拨打电话失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
 alert.tag = 888;
 [alert show];
 }
 @finally {
 
 }
 }
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
 {
 if (buttonIndex == 0) {
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://13135795795"]];
 }else{
 
 }
 
 }
 */   //联系客服 //调出电话
