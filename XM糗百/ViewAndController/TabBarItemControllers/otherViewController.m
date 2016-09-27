//
//  otherViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "otherViewController.h"
#import "NewsViewController.h"
#import "GameViewController.h"
#import "PhotoViewController.h"
#import "bookViewController.h"
#import "VideoViewController.h"
#import "MusicViewController.h"
#import "OtherViewSContent.h"
@implementation otherViewController

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
    
    NSString *cellPath = [[NSBundle mainBundle] pathForResource:@"MoreViewPlist" ofType:@"plist"];
    tableItemsArr = [NSArray arrayWithContentsOfFile:cellPath];
    [self setNavBar];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreemWidth, kScreemHeight-44-49-20) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    //设置背景
    [_tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundColor_login"]]];
    [self.view addSubview:_tableView];
    
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
    titleLabel.text = @"更多";
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
#pragma -mark UItableView  DataSource  & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableItemsArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = [tableItemsArr objectAtIndex:section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        cell.textLabel.textColor=[UIColor darkGrayColor];
    }
    NSArray *arr = [tableItemsArr objectAtIndex:indexPath.section];
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"textForLabel"];
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"Image"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0 && indexPath.row == 0) {
        //新闻
        NewsViewController *newsView = [[NewsViewController alloc] init];
        newsView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:newsView animated:YES completion:nil];
    }else if(indexPath.section == 0 && indexPath.row == 1){
        //游戏
        GameViewController *gameView = [[GameViewController alloc] init];
        gameView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:gameView animated:YES completion:nil];
    }else if(indexPath.section == 1 && indexPath.row == 0){
        //音乐
        MusicViewController *musicView = [[MusicViewController alloc ] init];
        musicView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:musicView animated:YES completion:nil];
    }else if(indexPath.section == 1 && indexPath.row == 1){
        //视频
        VideoViewController *videoView = [[VideoViewController alloc ] init];
        videoView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:videoView animated:YES completion:nil];
    }else if(indexPath.section == 2 && indexPath.row == 0){
        //小说
        bookViewController *bookView = [[bookViewController alloc] init];
        bookView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:bookView animated:YES completion:nil];
    }else if(indexPath.section == 2 && indexPath.row == 1){
        //美图
        PhotoViewController *photoView = [[PhotoViewController alloc ] init];
        photoView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:photoView animated:YES completion:nil];
    }else if(indexPath.section == 3 && indexPath.row == 0){
        //其它
        OtherViewSContent *otherView = [[OtherViewSContent alloc ] init];
        otherView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:otherView animated:YES completion:nil];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0f+25.0f;
    }return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}
@end
