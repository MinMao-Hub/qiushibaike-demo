//
//  QiushiDetailViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "QiushiDetailViewController.h"
#import "HMGLTransitionManager.h"
#import "Switch3DTransition.h"
#import "RequestComents.h"
#import "QiushiComentsModel.h"
#import "DetailCell.h"
#import "UserInformationViewController.h"
#import "UserDataManager.h"
#import "UserCenterViewController.h"
#import "loginView.h"
#import "MyselfInfomationViewController.h"
@implementation QiushiDetailViewController
{
    NSMutableArray *_listArray;
    NSInteger commitCount;
    NSDictionary *loginInfo;
}
@synthesize detailCell = _detailCell;
@synthesize qiushiId = _qiushiId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarController.tabBar.hidden = YES;
        [[UIDevice currentDevice] systemVersion];
    }
    return self;
}

#pragma mark - View lifecycle
- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBar];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreemWidth, kScreemHeight-44-40-5) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail_pulish_bg"]]];
    [self.view addSubview:_tableView];
    _listArray=[NSMutableArray array];
    [self loadData];
    
    _inputTextbackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreemHeight-40, kScreemWidth, 40)];
    _inputTextbackground.image = [UIImage imageNamed:@"input_background"];
    _inputTextbackground.userInteractionEnabled = YES;
    [self.view addSubview:_inputTextbackground];
    UITextField *inputText = [[UITextField alloc] initWithFrame:CGRectMake(40, 8, kScreemWidth-40-40-5, 24)];
    inputText.placeholder = @"说点什么吧...";
    inputText.delegate =self;
    [_inputTextbackground addSubview:inputText];
//设置发送按钮
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(kScreemWidth-40, 5, 30, 30);
    [sendBtn setImage:[UIImage imageNamed:@"night_biz_sns_publish_send_normal.png"] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    [_inputTextbackground addSubview:sendBtn];
}
- (void)viewDidLoad
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapForHiddenKeyboard:)];
    singleTap.delegate = self;
    [_tableView addGestureRecognizer:singleTap];
    
    tipView = [[UIView alloc] init];
    tipView.backgroundColor = [UIColor blackColor];
    tipView.alpha = 0;
    tipView.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
    tipView.layer.cornerRadius = 8;
    tipView.layer.masksToBounds = YES;
    tipView.bounds = CGRectMake(0, 0, 120, 70);
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 80)];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.text = @"评论发表中。。。";
    tipLabel.font = [UIFont systemFontOfSize:13.0f];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [tipView addSubview:tipLabel];
    [_tableView addSubview:tipView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)singleTapForHiddenKeyboard:(UIGestureRecognizer *)tap
{
    [UIView beginAnimations:@"Animation" context:@"textField"];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    _inputTextbackground.frame = CGRectMake(0, kScreemHeight-40, kScreemWidth, 40);
    [[[_inputTextbackground subviews] objectAtIndex:0] resignFirstResponder];
    [UIView commitAnimations];
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
    NSString *string = @"糗事";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [string stringByAppendingString:_qiushiId];
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavBar addSubview:titleLabel];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5, 27, 30, 30);
    [backButton addTarget:self action:@selector(backHomeAction:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:backButton];
    
    //分享
    //返回按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"shareBtn.png"] forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(kScreemWidth-35, 27, 30, 30);
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:shareButton];
}
//TODO:share_function
- (void)shareAction:(UIButton *)Btn
{
    shareView = [[SHSShareViewController alloc]initWithRootViewController:self];
    [shareView.view setFrame:CGRectMake(0, 0, kScreemWidth , kScreemHeight)];
    [self.view addSubview:shareView.view];
    shareView.sharedtitle = @"糗事百科--生活百态尽在Qiushibaike...";
    shareView.sharedText = _detailCell.textContent.text;
    shareView.sharedURL = @"http://www.qiushibaike.com";
    if ([_detailCell.largeImageString length] == 0) {
        shareView.sharedImageURL = @"http://static.qiushibaike.com/images/thumb/missing.png";
    }else{
        shareView.sharedImageURL = _detailCell.largeImageString;
    }
    [shareView showShareKitView];
//    shareView.view.hidden = NO;
//    [shareView showShareView];
//    [shareView showShareViewFromRect:CGRectMake(0, 0, 0, 0)];
}

- (void)backHomeAction:(UIButton *)sender
{
    Switch3DTransition *animation = [[Switch3DTransition alloc] init];
    animation.transitionType = Switch3DTransitionRight;
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    [[HMGLTransitionManager sharedTransitionManager] dismissModalViewController:self];
}
//请求数据
-(void)loadData
{
    [RequestComents requestComentsdata:self.qiushiId block:^(NSArray *Arr) {
     dispatch_async(dispatch_get_main_queue(), ^{
        [_listArray addObjectsFromArray:Arr];
         commitCount = Arr.count;
        [_tableView reloadData];
     });
    }];
}
#pragma -mark UItableView  DataSource  &Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _listArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        self.detailCell.layer.borderColor = [UIColor redColor].CGColor;
        cell=self.detailCell;
        
        return cell;
    }else{
        DetailCell *cell=[[DetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.backgroundColor=[UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        QiushiComentsModel *model=[[QiushiComentsModel alloc]init];
        model=[_listArray objectAtIndex:indexPath.row];
        cell.textLabel.text=model.userName;
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        cell.comentLabel.text = model.content;
        cell.comentLabel.numberOfLines=0;
        
        CGSize textSize=[model.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(220, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        
        cell.comentLabel.frame = CGRectMake(60, 32, 220, textSize.height);
        
        cell.imageView.image=model.iconImage;
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(kScreemWidth - 50, 15, 20, 20)];
        label.font = [UIFont systemFontOfSize:13];
        label.backgroundColor=[UIColor clearColor];
        label.text=[NSString stringWithFormat:@"%d",model.floor];
        [cell.contentView addSubview:label];
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return self.detailCell.frame.size.height;
    }
    else
    {
        QiushiComentsModel *qiuShi=[[QiushiComentsModel alloc] init];
        qiuShi=[_listArray objectAtIndex:indexPath.row];
        CGSize textSize=[qiuShi.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(220, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
        return textSize.height+40;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        QiushiComentsModel *comentModel = [[QiushiComentsModel alloc] init];
        
        Switch3DTransition *animation = [[Switch3DTransition alloc] init];
        animation.transitionType = Switch3DTransitionLeft;
        [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
        
        if (indexPath.row == commitCount) {
            comentModel = [_listArray lastObject];
            MyselfInfomationViewController *selfDetail = [[MyselfInfomationViewController alloc] init];
            //            //把用户名传入我的信息页面
            selfDetail.userNameForFront = [loginInfo objectForKey:@"loginUserName"];
            [[HMGLTransitionManager sharedTransitionManager]
             presentModalViewController:selfDetail onViewController:self];
        }else{
            comentModel = [_listArray objectAtIndex:indexPath.row];
            //创建模态视图，进入作者信息页面
            UserInformationViewController *userInfo = [[UserInformationViewController alloc] init];
            userInfo.userId=comentModel.userId;
            [[HMGLTransitionManager sharedTransitionManager]
             presentModalViewController:userInfo onViewController:self];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}
- (void)sendCommentAction:(UIButton *)sender
{
    UITextField *sendField = [_inputTextbackground.subviews objectAtIndex:0];
    if ([sendField.text length] == 0 || sendField.text == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    loginInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    
    UITextView *textView = [_inputTextbackground.subviews objectAtIndex:0];
    if ([[loginInfo objectForKey:@"isLogin"] isEqualToString:@"1"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评论发表成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        [UIView beginAnimations:@"Animation" context:@"textField"];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        _inputTextbackground.frame = CGRectMake(0, kScreemHeight-40, kScreemWidth, 40);
        [textView resignFirstResponder];
        tipView.alpha = 0.8;
        [UIView commitAnimations];
        [self performSelector:@selector(hiddenTipView) withObject:self afterDelay:1];
        
        //更新评论列表
        [self refershCommitList];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆后才能发表评论!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
    }
}
- (void)refershCommitList{
    
    UITextView *textView = [_inputTextbackground.subviews objectAtIndex:0];
    NSNumber *userId = [NSNumber numberWithInt:1224568768];
    //调用数据库  查找所有数据
    NSDictionary *userDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"1372092902",@"created_at",
                             userId,@"id",
                             @"iPhone6",@"last_visited_at",
                             @"匿名",@"login",
                             @"n",@"role",
                             @"active",@"state",
                             nil];
    //刷新评论列表
    NSDictionary *commitDic = [NSDictionary dictionaryWithObjectsAndKeys:textView.text,@"content",[NSString stringWithFormat:@"%ld",(_listArray.count + 1)],@"floor",@"1224568768",@"id",userDic,@"user", nil];
    QiushiComentsModel *qiuShiComent=[[QiushiComentsModel alloc]initWithDictionary:commitDic];
    
    [_listArray addObject:qiuShiComent];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
    //清除输入框中的内容
    textView.text = @"";
}
- (void)hiddenTipView
{
    [UIView beginAnimations:@"animation" context:@"text"];
    [UIView setAnimationDuration:0.5];
    tipView.alpha = 0;
    [UIView commitAnimations];
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView beginAnimations:@"Animation" context:@"textField"];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    _inputTextbackground.frame = CGRectMake(0, kScreemHeight-40, kScreemWidth, 40);
    [textField resignFirstResponder];
    [UIView commitAnimations];
    return YES;
}
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //判断当前输入法
    //do something   en-US为英文。。zh-Hans为中文
//    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString: @"en-US"])
//    {
        [UIView beginAnimations:@"Animation" context:@"textField"];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        _inputTextbackground.frame = CGRectMake(0, 64, kScreemWidth, 40);
        
        [UIView commitAnimations];
//    }else{
//        [UIView beginAnimations:@"Animation" context:@"textField"];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationDuration:0.3];
//        _inputTextbackground.frame = CGRectMake(0, kScreemHeight-250, kScreemWidth, 40);
//        
//        [UIView commitAnimations];
//    }
}
#pragma   -mark  UIGestureRecoginzerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ( _inputTextbackground.frame.origin.y == kScreemHeight-40) {
        return NO;
    }return YES;
}

/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWasChange:(NSNotification *)aNotification {
    NSString *str=[[UITextInputMode currentInputMode] primaryLanguage];
    
    NSLog(@"shurufa--------------%@",str);
    
        if ([str isEqualToString:@"zh-Hans"]) {
    
            _inputTextbackground.frame = CGRectMake(0, 460-290, kScreemWidth, 45);
    
        }else if ([str isEqualToString:@"en-US"])
    
        {
            _inputTextbackground.frame = CGRectMake(0, 460-254, kScreemWidth, 45);
    
        }else{
            _inputTextbackground.frame = CGRectMake(0, 460-40, kScreemWidth, 45);
        }
    NSDictionary *info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    if (kbSize.height == 216) {
        NSLog(@"english");
        _inputTextbackground.frame = CGRectMake(0, 460-254, kScreemWidth, 45);
    }else if(kbSize.height == 252){
        NSLog(@"中文");
        _inputTextbackground.frame = CGRectMake(0, 460-292, kScreemWidth, 45);
    }else{
        _inputTextbackground.frame = CGRectMake(0, 460-40, kScreemWidth, 45);
    }
}*/  //通知 ios 动态监听键盘输入法和高度
@end
