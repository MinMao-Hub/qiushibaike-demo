//
//  AboutQiuBai.m
//  YouKown
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "AboutQiuBai.h"

@implementation AboutQiuBai

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aboutQiubai"]];
    imageView.frame=CGRectMake(0, 64, kScreemWidth, kScreemHeight-64);
    [self.view addSubview:imageView];
    [self setNavBar];
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
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, 20, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"关于糗事百科";
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
}
- (void)backHomeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
