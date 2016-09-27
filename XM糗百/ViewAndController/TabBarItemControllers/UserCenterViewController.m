//
//  UserCenterViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "UserCenterViewController.h"
#import "loginView.h"
#import "registerView.h"
#import "MyselfInfomationViewController.h"
@implementation UserCenterViewController

@synthesize isLogin;
@synthesize loginedUserName = _loginedUserName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isLogin = NO;
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
    [self setNavBar];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreemWidth, 130)];
    imageView.image = [UIImage imageNamed:@"12"];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+130+20, kScreemWidth, kScreemHeight-49-44-130-20) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    //设置背景
    [_tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundColor_login"]]];
    [self.view addSubview:_tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLoginState:) name:@"changeLoginState" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requireUserName:) name:kRegisterUserName object:nil];
}
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
}
- (void)changeLoginState:(NSNotification *)notification
{
    isLogin = YES;
    
    id result = notification.object;
    NSString *userName = result;
    _loginedUserName = userName;
    
    [[NSUserDefaults standardUserDefaults] setObject:@{@"isLogin":[NSString stringWithFormat:@"%d",1],@"loginUserName":userName} forKey:@"login"];
    [_tableView reloadData];
}
- (void)requireUserName:(NSNotification *)notification
{
    id result = notification.object;
    _loginedUserName = result;
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
    titleLabel.text = @"个人中心";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:25.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavBar addSubview:titleLabel];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
#pragma -mark UITableView -- Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 2;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        if(isLogin){
            cell.textLabel.text = _loginedUserName;
        }else{
            cell.textLabel.text = @"登录";
        }
    }else if(indexPath.section == 0 && indexPath.row == 1){
        if(isLogin){
            cell.textLabel.text = @"退出登录";
        }else{
            cell.textLabel.text = @"注册";
        }
    }else if(indexPath.section == 1 && indexPath.row == 0){
        cell.textLabel.text = @"管理我的糗事";
    }else if(indexPath.section == 1 && indexPath.row == 1){
        cell.textLabel.text = @"我的收藏";
    }else if(indexPath.section == 2 && indexPath.row == 0){
        cell.textLabel.text = @"说明";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0 && indexPath.row == 0) {
//        登录 ｜ 个人信息
        if(self.isLogin)
        {
            MyselfInfomationViewController *selfDetail = [[MyselfInfomationViewController alloc] init];
//            //把用户名传入我的信息页面
            selfDetail.userNameForFront = _loginedUserName;
            [self presentViewController:selfDetail animated:YES completion:nil];
        }else
        {
            loginView *login = [[loginView alloc] init];
            login.userNameText = _loginedUserName;
            [self presentViewController:login animated:YES completion:nil];
        }
    
    }else if(indexPath.section == 0 && indexPath.row == 1){
//        //注册 ｜ 退出登录
        if(self.isLogin)
        {
            self.isLogin = NO;
            [tableView reloadData];
        }else
        {
            registerView *registerUser = [[registerView alloc] init];
            registerUser.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:registerUser animated:YES completion:nil];
        }
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
        //管理我的糗事
        if (self.isLogin) {
            UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你还没有发表过糗事，马上去发表！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warn show];
        }else{
            UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你还没有登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warn show];
        }
    }else if(indexPath.section == 1 && indexPath.row == 1){
        //我的收藏
        if (self.isLogin) {
            UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你还没有收藏过糗事，马上去收藏！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warn show];
        }else{
            UIAlertView *warn = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你还没有登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [warn show];
        }
    }else{
        //说明
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0f+25.0f;
    }return 5.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}
@end
