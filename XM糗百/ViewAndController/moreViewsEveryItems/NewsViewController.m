//
//  NewsViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"

@implementation NewsViewController

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
//    [self setNavBar];
    [self setWebView];
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

- (void)setNavBar
{
    //添加导航栏
     UIImageView *myNavBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, 64)];
    myNavBar.userInteractionEnabled = YES;
    myNavBar.image = [UIImage imageNamed:@"news_nav_bg"];
    myNavBar.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:myNavBar];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 130)/2, 20, 130, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"新闻";
    titleLabel.textColor = [UIColor whiteColor];

    titleLabel.font = [UIFont systemFontOfSize:18.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavBar addSubview:titleLabel];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back_biz_news_column_drag_normal"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(2, 27, 30, 30);
    [backButton addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:backButton];
    
    UIImageView *textImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 4, 50, 35)];
    textImageView.image = [UIImage imageNamed:@"netease_top"];
    
    [myNavBar addSubview:textImageView];
}
- (void)backHomeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setWebView
{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, kScreemHeight)];
    [webView setUserInteractionEnabled:YES];
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.directionalLockEnabled = NO;
    NSURL *url = [NSURL URLWithString:@"http://m.sohu.com/c/2/?_once_=000025_top_xinwen_v3"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
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
    
    backButton.frame = CGRectMake(2, 7, 30, 30);
    [backButton addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [webView addSubview:backButton];
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
@end
