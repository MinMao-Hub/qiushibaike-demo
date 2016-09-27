//
//  MessageViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MessageViewController.h"
#import "MapView Controller.h"
@implementation MessageViewController

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
    [self setNavBar];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreemWidth, kScreemHeight-49-44-20)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 145, 20, 20)];
    imageView.image = [UIImage imageNamed:@"warning_about_icon"];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 147, kScreemWidth, 20)];
    label.font = [UIFont fontWithName:@"Party LET" size:16.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor darkGrayColor];
    label.text = @"亲！你还没有发过小纸条哦！";
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    [self.view addSubview:view];
    
    
}
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
}
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
    titleLabel.text = @"小纸条";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:25.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavBar addSubview:titleLabel];
    
    //搜索周边按钮
    UIButton *surroundingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [surroundingBtn setImage:[UIImage imageNamed:@"navigationbar_interest_highlighted"] forState:UIControlStateNormal];
    surroundingBtn.frame = CGRectMake(15, 27, 30, 30);
    [surroundingBtn addTarget:self action:@selector(surroundingBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:surroundingBtn];
    
    // 添加按钮（写小纸条）
    UIButton *addTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addTextBtn setImage:[UIImage imageNamed:@"Navbar_profile_user"] forState:UIControlStateNormal];
    addTextBtn.frame = CGRectMake(self.view.frame.size.width - 50, 27, 30, 30);
    
    [addTextBtn addTarget:self action:@selector(whiteTextAction:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:addTextBtn];
}
- (void)surroundingBtnAction:(UIButton *)sender
{
    //搜索周边   调出地图
    MapView_Controller *mapView = [[MapView_Controller alloc] init];
    mapView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:mapView animated:YES completion:nil];
}
- (void)whiteTextAction:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"温馨提示" 
                          message:@"你还没有添加糗友哦！" 
                          delegate:self 
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles: nil];
    [alert show];
}
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
