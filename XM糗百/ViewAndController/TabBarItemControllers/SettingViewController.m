//
//  SettingViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutQiuBai.h"

@implementation SettingViewController
{
    UITableView *_tableView;
    NSArray     *_titlesArr;
    UIView      *fontView;
    UIView      *loadImageView;
    NSString    *stringFontSize;
    NSString    *stringLoadImage;
    UIView *viewForBlackBG;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        stringFontSize = @"正常";
        stringLoadImage = @"自动加载";
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreemWidth, kScreemHeight-44-20) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    _titlesArr=[NSArray arrayWithObjects:@"清除缓存",@"字号大小",@"图片加载方式",@"提醒与通知",@"意见反馈",@"果断点赞",@"新版本检测",@"关于糗百", nil];
    [self setNavBar];
    //设置背景
    [_tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundColor_login"]]];
    
    //设置背景半透明
    viewForBlackBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, kScreemHeight)];
    viewForBlackBG.backgroundColor = [UIColor blackColor];
    viewForBlackBG.alpha = 0.7;
    viewForBlackBG.hidden = YES;
    //添加单击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapForHidden:)];
    [viewForBlackBG addGestureRecognizer:singleTap];
    [self.view addSubview:viewForBlackBG];
    
    //字体大小修改
    fontView = [[UIView alloc]initWithFrame:CGRectMake((kScreemWidth - 220)/2, (kScreemHeight - 93)/2 - 20, 220, 123)];
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
    headLabel.backgroundColor = [UIColor clearColor];
    fontView.backgroundColor = [UIColor whiteColor];
    headLabel.text = @"请选择字体大小";
    headLabel.textColor = [UIColor redColor];
    [fontView addSubview:headLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 220, 3)];
    lineLabel.backgroundColor = [UIColor redColor];
    [fontView addSubview:lineLabel];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 33, 220, 30);
    button1.tag = 101;
    [button1 setTitle:@"缩小" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(changeFont:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 63, 220, 30);
    button2.tag = 102;
    [button2 setTitle:@"正常" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(changeFont:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(0, 93, 220, 30);
    button3.tag = 103;
    [button3 setTitle:@"加大" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(changeFont:) forControlEvents:UIControlEventTouchUpInside];
    
    [fontView addSubview:button1];
    [fontView addSubview:button2];
    [fontView addSubview:button3];
    
    [self.view addSubview:fontView];
    fontView.hidden = YES;
    
    //修改图片的加载方式
    loadImageView = [[UIView alloc]initWithFrame:CGRectMake((kScreemWidth - 220)/2, (kScreemHeight - 93)/2 - 20, 220, 93)];
    UILabel *headLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 30)];
    headLabel2.backgroundColor = [UIColor clearColor];
    loadImageView.backgroundColor = [UIColor whiteColor];
    headLabel2.text = @"请选择图片加载方式";
    headLabel2.textColor = [UIColor redColor];
    [loadImageView addSubview:headLabel2];
    
    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 220, 3)];
    lineLabel2.backgroundColor = [UIColor redColor];
    [loadImageView addSubview:lineLabel2];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(0, 33, 220, 30);
    button4.tag = 104;
    [button4 setTitle:@"自动加载" forState:UIControlStateNormal];
    [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(changeLoadImageMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(0, 63, 220, 30);
    button5.tag = 105;
    [button5 setTitle:@"仅wifi下加载" forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(changeLoadImageMethod:) forControlEvents:UIControlEventTouchUpInside];
    [loadImageView addSubview:button4];
    [loadImageView addSubview:button5];
    [self.view addSubview:loadImageView];
    loadImageView.hidden = YES;
    
}
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
}
- (void)singleTapForHidden:(UITapGestureRecognizer *)tap
{
    //隐藏弹出的视图
    fontView.hidden = YES;
    loadImageView.hidden = YES;
    viewForBlackBG.hidden = YES;
    
}
//关于字体改变
-(void)changeFont:(UIButton *)button
{
    NSNumber *fontSize;
    if(button.tag == 101){
        fontSize = [NSNumber numberWithFloat: 12.0];
        stringFontSize = @"缩小" ;
    }else if(button.tag == 102){
        fontSize = [NSNumber numberWithFloat: 13.5];
        stringFontSize = @"正常" ;
    }else{
        fontSize = [NSNumber numberWithFloat: 15.0];
        stringFontSize = @"加大" ;
    }
    [_tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fontChange" object:fontSize];
    fontView.hidden = YES;
    viewForBlackBG.hidden = YES;
}
//关于图片加载方式的改变
- (void)changeLoadImageMethod:(UIButton *)button
{
    NSNumber *isLoadImage;
    if(button.tag == 104){
        stringLoadImage = @"自动加载" ;
        isLoadImage = [NSNumber numberWithInt:1];
    }else{
        stringLoadImage = @"仅wifi下加载" ;
        isLoadImage = [NSNumber numberWithInt:0];
    }
    [_tableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imageLoadMethodChange" object:isLoadImage];
    loadImageView.hidden = YES;
    viewForBlackBG.hidden = YES;

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
    titleLabel.text = @"设置";
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
#pragma mark - tableView datasource
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.text=[_titlesArr objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    
    if(indexPath.row==1)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(kScreemWidth - 55, 12, 30, 20)];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:14];

        label.text= stringFontSize;
        [cell.contentView addSubview:label];
    }else if(indexPath.row==2)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(kScreemWidth - 115, 12, 100, 20)];
        label.backgroundColor=[UIColor clearColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font=[UIFont systemFontOfSize:14]; 
        label.text=stringLoadImage;
        [cell.contentView addSubview:label];
    }
    return cell;
    
}
#pragma mark - tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row==1)
    {
        viewForBlackBG.hidden = NO;
        fontView.hidden = NO;
        loadImageView.hidden = YES;
    }
    if(indexPath.row==2)
    {
        loadImageView.hidden = NO;
        viewForBlackBG.hidden = NO;
        fontView.hidden = YES;
    }

    if(indexPath.row==6)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"该版本已为最新版本！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    if(indexPath.row==7){
        AboutQiuBai *aboutQiuBai=[[AboutQiuBai alloc]init];
        [self presentViewController:aboutQiuBai animated:YES completion:nil];
        
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
