//
//  WriteMyTextViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-10-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "WriteMyTextViewController.h"

@implementation WriteMyTextViewController

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
 - (void)loadView
 {
    [super loadView];
    [self setWebView];
 }
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
    UIImageView *statusbar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, 20)];
    statusbar.image = [UIImage imageNamed:@"writeText_nav_bg"];
    [self.view addSubview:statusbar];
}
 //添加WebView
 - (void)setWebView
 {
     webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kScreemWidth, kScreemHeight-20+150)];
     [webView setUserInteractionEnabled:YES];
     webView.scrollView.bounces = NO;
     webView.scrollView.showsHorizontalScrollIndicator = NO;
     webView.scrollView.showsVerticalScrollIndicator = NO;
     webView.scrollView.directionalLockEnabled = NO;
     NSURL *url = [NSURL URLWithString:@"http://www.qiushibaike.com/add"];
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
     
     //返回按钮
     UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
     backButton.frame = CGRectMake(2, 3, 30, 30);
     [backButton addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
     [webView addSubview:backButton];
 
 }
 - (void)backHomeAction:(UIButton *)sender
 {
     [self dismissViewControllerAnimated:YES completion:nil];
 }
 
@end
