//
//  UserInformationViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "UserInformationViewController.h"
#import "HMGLTransitionManager.h"
#import "Switch3DTransition.h"
#import "RquestUserData.h"
#import "PersonalInfoCell.h"
#import "DoorsTransition.h"
#import "UserInfo.h"
#import "QiuShi.h"
#import "RequestUserQiushi.h"
#import "QiushiDetailViewController.h"
@implementation UserInformationViewController
{
    UITableView *_personerQiuShiView;//个人糗事
    UITableView *_personerView;//个人简介
    NSArray     *_listUserInfoArray;
    //头像
    UIImageView *headIcon;
    //昵称
    UILabel *userNameLabel;
    //个性签名
    UILabel *signatureLabel;
}
@synthesize userId;
@synthesize surperView = _surperView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarController.tabBar.hidden = YES;
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
    [self setTabBar];
    [self loadData];
    [self setMainView];
    [self loadUserQiushiData];
    
}
- (void)viewDidLoad
{

}
-(void)loadData
{
    [RquestUserData requestUserData:self.userId block:^(NSArray *Arr){
        dispatch_async(dispatch_get_main_queue(), ^{
            _listUserInfoArray = Arr;
            [self setheadImageWithLabels];
            [_personerView reloadData];
        });

    }];
    
}
-(void)loadUserQiushiData
{
    [RequestUserQiushi requestUserQiushi:self.userId block:^(NSArray *Arr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _userQiushiArray = Arr;
            
            [_personerQiuShiView reloadData];
        });
        
    }];
}

- (void)setNavBar
{
    //添加导航栏
    myNavBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, 64)];
    myNavBar.userInteractionEnabled = YES;
    myNavBar.image = [UIImage imageNamed:@"nav_bg"];
    myNavBar.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:myNavBar];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 140)/2, 20, 140, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"TA的主页";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavBar addSubview:titleLabel];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5, 27, 30, 30);
    [backButton addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:backButton];
}
- (void)setTabBar
{
    //添加TabBar
    myTabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreemHeight-40, kScreemWidth, 40)];
    myTabBar.image = [UIImage imageNamed:@"nav_bg"];
    
    [self.view addSubview:myTabBar];
    
    //添加button
    UIButton *msgButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [msgButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    msgButton.frame=CGRectMake(0, 0, kScreemWidth/2, 40);
    [myTabBar addSubview:msgButton];
    //添加label
    //小纸条
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 60, 40)];
    message.backgroundColor = [UIColor clearColor];
    message.text = @"小纸条";
    message.textColor = [UIColor whiteColor];
    message.font = [UIFont systemFontOfSize:16.f];
    message.textAlignment = NSTextAlignmentLeft;
    [msgButton addSubview:message];
    
    
    UIButton *reportButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [reportButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    reportButton.frame=CGRectMake(kScreemWidth/2, 0, kScreemWidth/2, 40);
    [myTabBar addSubview:reportButton];
    //举报
    UILabel *report = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 60, 40)];
    report.backgroundColor = [UIColor clearColor];
    report.text = @"举报";
    report.textColor = [UIColor whiteColor];
    report.font = [UIFont systemFontOfSize:16.f];
    report.textAlignment = NSTextAlignmentLeft;
    [reportButton addSubview:report];
    
}
- (void)backHomeAction:(UIButton *)sender
{
    Switch3DTransition *animation = [[Switch3DTransition alloc] init];
    animation.transitionType = Switch3DTransitionRight;
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    [[HMGLTransitionManager sharedTransitionManager] dismissModalViewController:self];
}
-(void)setMainView
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreemWidth, 120)];
    imageView.image=[UIImage imageNamed:@"user_info_topImage"];
    //头像
    headIcon=[[UIImageView alloc]initWithFrame:CGRectMake(20, 55, 50, 50)];
    
    headIcon.layer.cornerRadius = 5;
    headIcon.layer.masksToBounds = YES;
    
    headIcon.layer.borderWidth = 1;
    headIcon.layer.borderColor = [UIColor redColor].CGColor;
    
    [imageView addSubview:headIcon];
    [self.view addSubview:imageView];
    //昵称
    userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 57, 245, 20)];
    userNameLabel.backgroundColor=[UIColor clearColor];
    userNameLabel.font = [UIFont systemFontOfSize:16.0f];
    //个性签名
    signatureLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 80, 200, 40)];
    signatureLabel.backgroundColor=[UIColor clearColor];
    signatureLabel.font = [UIFont systemFontOfSize:13.0f];
    signatureLabel.numberOfLines = 0;
    [imageView addSubview:userNameLabel];
    [imageView addSubview:signatureLabel];
//分栏
    UIImageView *divideImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 164+20, kScreemWidth, 35)];
    divideImageView.image=[UIImage imageNamed:@"tabBar"];
    [self.view addSubview:divideImageView];
    divideImageView.userInteractionEnabled = YES;
    //简介按钮
    UIButton *simpleIntreduceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [simpleIntreduceBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [simpleIntreduceBtn setTitle:@"简介" forState: UIControlStateNormal];
    simpleIntreduceBtn.frame=CGRectMake(0, 0, kScreemWidth/2, 32);
    [simpleIntreduceBtn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    simpleIntreduceBtn.tag = 101;
    [divideImageView addSubview:simpleIntreduceBtn];
    //糗事按钮
    UIButton *userQiuShiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [userQiuShiBtn setTitle:@"糗事" forState: UIControlStateNormal];
    userQiuShiBtn.frame=CGRectMake(kScreemWidth/2, 0, kScreemWidth/2, 32);
    [userQiuShiBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    userQiuShiBtn.tag = 102;
    [userQiuShiBtn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    [divideImageView addSubview:userQiuShiBtn];
    
    moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, kScreemWidth/2, 3)];
    moveLabel.backgroundColor = [UIColor orangeColor];
    [divideImageView addSubview:moveLabel];
    
    //内容切换的根视图
    _surperView=[[UIView alloc]initWithFrame:CGRectMake(0, 199+20, kScreemWidth, kScreemHeight-20-199-44)];
    [self.view addSubview:_surperView];
    
    //里面再放两个View 进行交换
    //他的糗事页
    _personerQiuShiView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, kScreemHeight-20-199-44) style:UITableViewStyleGrouped];
    _personerQiuShiView.backgroundColor = [UIColor whiteColor];
    _personerQiuShiView.tag=103;
    _personerQiuShiView.dataSource = self;
    _personerQiuShiView.delegate = self;
    _personerQiuShiView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_surperView addSubview:_personerQiuShiView];

    //个人信息页
    _personerView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, kScreemHeight-20-199-40)];
    _personerView.tag=104;
    _personerView.dataSource = self;
    _personerView.delegate = self;
    _personerView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_surperView addSubview:_personerView];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_personerQiuShiView reloadData];
}
- (void)changeView:(UIButton *)sender
{
    if (sender.tag == 101) {
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.3];
        moveLabel.frame = CGRectMake(0, 32, kScreemWidth/2, 3);
        if(_personerQiuShiView==[_surperView.subviews objectAtIndex:1])
            [_surperView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
        [UIView commitAnimations];
        
    }else{
        [UIView beginAnimations:@"Animation" context:nil];
        [UIView setAnimationDuration:0.3];
        moveLabel.frame = CGRectMake(kScreemWidth/2, 32, kScreemWidth/2, 3);
        if(_personerView==[_surperView.subviews objectAtIndex:1])
            [self.surperView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        [UIView commitAnimations];
    }
    
}
//给大图片中的label和头像赋值
- (void)setheadImageWithLabels
{
    UserInfo *user = [[UserInfo alloc] init];
    user = [_listUserInfoArray objectAtIndex:0];
    userNameLabel.text = user.userName;
    if ([user.signature length] == 0) {
        signatureLabel.text = @" 这家伙很懒，啥也没写 ";
    }else{
        signatureLabel.text = user.signature;
    }
    headIcon.image = user.userIcon;
}
#pragma mark - tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==(UITableView *)[_surperView viewWithTag:104])
    {
        return 10;
    }else{
        return [_userQiushiArray count];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    //用户信息表
    if(tableView==(UITableView *)[_surperView viewWithTag:104])
    {
        
        PersonalInfoCell *cell= [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        UserInfo *userInfo = [[UserInfo alloc] init];
        userInfo = [_listUserInfoArray objectAtIndex:0];
        if (indexPath.row == 0) {
            cell.label2.text = @"年龄性别";
            cell.label3.frame = CGRectMake(100, 0, 25, 36);
            cell.label3.text = [NSString stringWithFormat:@"%d",userInfo.age];
            cell.label1.text = userInfo.astrology;
            
            cell.imgView.frame = CGRectMake(125, 8, 20, 20);
            if ([userInfo.gender isEqualToString:@"F"]) {
                cell.imgView.image = [UIImage imageNamed:@"Female"];
            }else{
                cell.imgView.image = [UIImage imageNamed:@"Male"];
            }
        }else if(indexPath.row == 1){
            cell.label2.text = @"兴趣爱好";
            cell.label3.text = userInfo.hobby;
            if ([userInfo.hobby length] == 0) {
                cell.label3.text = @"  -- --";
            }
            cell.label3.frame = CGRectMake(100, 0, 200, 36);
        }else if(indexPath.row == 2){
            cell.label2.text = @"常出没地";
            cell.label3.text = userInfo.haunt;
            if ([userInfo.haunt length] == 0) {
                cell.label3.text = @"  -- --";
            }
            cell.label3.frame = CGRectMake(100, 0, 200, 36);
        }else if(indexPath.row == 3){
            cell.label2.text = @"工作";
            cell.label3.text = userInfo.job;
            if ([userInfo.job length] == 0) {
                cell.label3.text = @"  -- --";
            }
            cell.label3.frame = CGRectMake(100, 0, 200, 36);
        }else if(indexPath.row == 4){
            cell.label2.text = @"位置";
            cell.label3.text = userInfo.location;
            if ([userInfo.location length] == 0) {
                cell.label3.text = @"  -- --";
            }
            cell.label3.frame = CGRectMake(100, 0, 200, 36);
        }else if(indexPath.row == 5){
            cell.label2.text = @"糗龄";
            if (userInfo.qb_age/30 < 12) {
                cell.label3.text = [NSString stringWithFormat:@"%d个月",userInfo.qb_age/30];
            }else{
                cell.label3.text = [NSString stringWithFormat:@"%d年",userInfo.qb_age/(30*12)];
            }
            cell.label3.frame = CGRectMake(100, 0, 200, 36);
        }
        else if(indexPath.row == 6){
            cell.label2.text = @"家乡";
            cell.label3.text = userInfo.hometown;
            if ([userInfo.hometown length] == 0) {
                cell.label3.text = @"  -- --";
            }
            cell.label3.frame = CGRectMake(100, 0, 200, 36);
        }else if(indexPath.row == 7){
            cell.label2.text = @"爪机品牌";
            cell.label3.text = userInfo.mobile_brand;
            if ([userInfo.mobile_brand length] == 0) {
                cell.label3.text = @"  -- --";
            }
            cell.label3.frame = CGRectMake(100, 0, 200, 36);
        }else if(indexPath.row == 8){
            cell.label2.text = @"糗事条数";
            cell.label3.text = [NSString stringWithFormat:@"%d",userInfo.qs_count];
            cell.label3.frame = CGRectMake(100, 0, 200, 36);
        }else if(indexPath.row == 9){
            cell.label2.text = @"注册时间";
            if ([userInfo.createTime intValue] != 0) {
                NSDate *date=[NSDate dateWithTimeIntervalSince1970:[userInfo.createTime floatValue]];
                NSDateFormatter *df = [[NSDateFormatter alloc]init];
                [df setDateFormat:@"yyyy-MM-dd"];
                NSString *time = [df stringFromDate:date];
                cell.label3.text = time;
            }else{
                cell.label3.text = @"-- -- --";
            }
            cell.label3.frame = CGRectMake(100, 0, 200, 36);
        }
        return cell;

    }else{//某个用户的个人糗事表
        UserQiushiCell *cell= [[UserQiushiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            //单元格选中样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.layer.borderColor = [UIColor greenColor].CGColor;
        cell.layer.borderWidth = 1;
        //设置自适应大小        
        QiuShi *qiuShi=[[QiuShi alloc]init];
        qiuShi=[_userQiushiArray objectAtIndex:indexPath.row];
        
        //搭建框架
        CGSize textSize=[qiuShi.content sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeHeadTruncation];
        cell.textContent.frame=CGRectMake(15, 5, 290, textSize.height);
        
        cell.imageContent.frame=CGRectMake(15,10+textSize.height, qiuShi.imageWidth, qiuShi.imageHeight);
        //顶
        cell.upBtn.frame = CGRectMake(20, qiuShi.imageHeight+textSize.height+19, 20, 20);
        [cell.upBtn setImage:[UIImage imageNamed:@"qiushi_content_like"] forState:UIControlStateNormal];
        //添加事件
        
        cell.upCountLabel.frame = CGRectMake(45, qiuShi.imageHeight+textSize.height+20, 40, 16);
        cell.upCountLabel.text = [NSString stringWithFormat:@"%d",qiuShi.upCount];
        
        //踩
        cell.downBtn.frame = CGRectMake(85, qiuShi.imageHeight+textSize.height+20, 20, 20);
        [cell.downBtn setImage:[UIImage imageNamed:@"qiushi_content_unLike"] forState:UIControlStateNormal];
        cell.downCountLabel.frame = CGRectMake(107, qiuShi.imageHeight+textSize.height+20, 40, 16);
        cell.downCountLabel.text = [NSString stringWithFormat:@"%d",qiuShi.downCount];
        
        //评论
        cell.commentBtn.frame = CGRectMake(240, qiuShi.imageHeight+textSize.height+19, 20, 20);
        
        cell.comentCountlabel.frame = CGRectMake(265, qiuShi.imageHeight+textSize.height+19, 40, 20);
        [cell.commentBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
        cell.comentCountlabel.font = [UIFont systemFontOfSize:13.0];
        cell.comentCountlabel.text = [NSString stringWithFormat:@"%d",qiuShi.commentsCount];
        
        //给各个项目赋相应的值
        qiuShi=[_userQiushiArray objectAtIndex:indexPath.row];
        
//        cell.imageContent.image=qiuShi.contentImage;
        //[self creatImageURL:qiuShi.imageURL];
        //加载图片
        cell.largeImageString = qiuShi.largeImageURL;
        dispatch_queue_t queue = dispatch_queue_create("image", NULL);
        dispatch_async(queue, ^{
            NSURL *url = [NSURL URLWithString:qiuShi.imageURL];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.imageContent.image=img;
            }); 
        });

        
        cell.textContent.text=qiuShi.content;
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==(UITableView *)[_surperView viewWithTag:104]) {;
        return tableView.bounds.size.height/10;
    }else{
        QiuShi *qiuShi=[[QiuShi alloc]init];
        qiuShi=[_userQiushiArray objectAtIndex:indexPath.row];
        float imgHeigth=qiuShi.imageHeight;
        CGSize textSize=[qiuShi.content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        return imgHeigth+textSize.height+45;
    }
    
}    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==(UITableView *)[_surperView viewWithTag:103]) {
        QiuShi *qiuShi=[[QiuShi alloc]init];
        qiuShi=[_userQiushiArray objectAtIndex:indexPath.row];
        
        //创建模态视图，进入作者的某条糗事详情页
        DoorsTransition *animation = [[DoorsTransition alloc] init];
        
        [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
        QiushiDetailViewController *qiushiInfo = [[QiushiDetailViewController alloc] init];
        UITableViewCell *iCell=[[UITableViewCell alloc]init];
        iCell= [tableView cellForRowAtIndexPath:indexPath];
        qiushiInfo.detailCell = (myCell *)iCell;
        qiushiInfo.qiushiId=qiuShi.qiushiID;
        [[HMGLTransitionManager sharedTransitionManager]
         presentModalViewController:qiushiInfo onViewController:self];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==(UITableView *)[_surperView viewWithTag:103])
    {
        return 10.0f;
    }return 1.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==(UITableView *)[_surperView viewWithTag:103])
    {
        return 10.0f;
    }return 1.0;
}
@end
