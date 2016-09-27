//
//  MianViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MianViewController.h"
#import "myCell.h"
#import "QiuShi.h"
#import "RequestData.h"
#import "RquestUserData.h"
#import "UserInformationViewController.h"
#import "HMGLTransitionManager.h"
#import "ClothTransition.h"
#import "Switch3DTransition.h"
#import "HeadButton.h"
#import "QiushiDetailViewController.h"
#import "ASIFormDataRequest.h"
#import "pictureDetailViewController.h"
#import "WriteMyTextViewController.h"
static NSArray *loadingArray;
@implementation MianViewController
{
    CGSize _size;
    NSArray *_dataArray;
    UIButton *tempButton;
}
static CGFloat fontSize;
static bool isLoadImage;
@synthesize detail=_detail;
@synthesize image;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        fontSize = 13.5;
        isLoadImage = YES;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    return self;
}
#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, kScreemHeight)];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
    //添加NavBar
    [self setNavBar];
    //添加上面的TabBar
    [self setKindOfTabBar];
    
    //字体大小设置通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTextFont:) name:@"fontChange" object:nil];
    //图片加载方式设置通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLoadImageMethod:) name:@"imageLoadMethodChange" object:nil];
    
    //添加ScrollView
    [self setScrollView];
    
    [self loadData:SuggestURLString(30,1) tableViewWithTag:11];
    
}
-(void)changeTextFont:(NSNotification *)notification
{
    id result = notification.object;
    fontSize = [result floatValue];
}
-(void)changeLoadImageMethod:(NSNotification *)notification
{
    id result = notification.object;
    if([result intValue] == 0)
    {
        //判断是否为2G／3G网
        if ([ASIFormDataRequest isNetworkReachableViaWWAN]) {
            isLoadImage = NO;
        }else{
            isLoadImage = YES;
        }
    }else{
        isLoadImage = YES;
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建下拉刷新视图的属性
    PullTableView *tableView = (PullTableView *)[self.view viewWithTag:11];
    tableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    tableView.pullBackgroundColor = [UIColor whiteColor];
    tableView.pullTextColor = [UIColor blackColor];
    if (!tableView.pullTableIsRefreshing) {
        tableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(pullRefreshTable) withObject:nil afterDelay:2.0f];
    }
    [tableView reloadData];
    
    tempButton = (UIButton *)[kindOfTabBar subviews][3];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelectorOnMainThread:@selector(reloadTableViewData) withObject:nil waitUntilDone:YES];
}

- (void)reloadTableViewData
{
    int currentIndex = _scrollView.contentOffset.x/kScreemWidth;
    PullTableView *tableView = (PullTableView *)[self.view viewWithTag:11+currentIndex];
    [tableView reloadData];
}

- (void)setScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 79+20, kScreemWidth, kScreemHeight-44-49-35-20)];
    _scrollView.contentSize = CGSizeMake(kScreemWidth*5, kScreemHeight-44-49-35-20);
    _scrollView.pagingEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    //添加TableView
    for (int i = 0; i < 5; i++) {
        PullTableView *_tableView = [[PullTableView alloc] initWithFrame:CGRectMake(0+kScreemWidth*i, 0, kScreemWidth, kScreemHeight-44-44-35-22) style:UITableViewStyleGrouped];
        [_tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pulish_bg"]]];
        _tableView.tag = 11+i;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.pullDelegate = self;
        _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
        //_tableView.separatorColor=[UIColor redColor];
        _tableView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
        _tableView.pullBackgroundColor = [UIColor whiteColor];
        _tableView.pullTextColor = [UIColor blackColor];
        [_scrollView addSubview:_tableView];
    }
    
    [self.view addSubview:_scrollView];
    
    //添加一个按钮，可以让表滑动到顶部
    UIButton *scrollToTop = [UIButton buttonWithType:UIButtonTypeCustom];
    [scrollToTop setImage:[UIImage imageNamed:@"scrollToTop"] forState:UIControlStateNormal];
    [scrollToTop setAlpha:0.4];
    scrollToTop.frame = CGRectMake(kScreemWidth - 50, kScreemHeight-49-kNavBarHeight, 35, 35);
    
    [scrollToTop addTarget:self action:@selector(scrollToTopAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scrollToTop];
}
- (void)scrollToTopAction
{
    int currentIndex = _scrollView.contentOffset.x/kScreemWidth;
    PullTableView *tableView = (PullTableView *)[self.view viewWithTag:11+currentIndex];
    //让表视图滑动到顶部
    [tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)setNavBar
{
    //添加导航栏
    myNavBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, kNavBarHeight)];
    myNavBar.userInteractionEnabled = YES;
    myNavBar.image = [UIImage imageNamed:@"writeText_nav_bg"];//writeText_nav_bg nav_bg
    myNavBar.backgroundColor = [UIColor purpleColor];
    [view addSubview:myNavBar];
    
    //添加标题
    UIImageView *titltImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 120)/2, 24, 120, 36)];
    titltImgView.image = [UIImage imageNamed:@"main_title_img"];
    [myNavBar addSubview:titltImgView];
    // 添加按钮（写糗事）
    UIButton *addTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addTextBtn setImage:[UIImage imageNamed:@"navigationbar_compose_highlighted@2x"] forState:UIControlStateNormal];
    addTextBtn.frame = CGRectMake(self.view.frame.size.width - 45, 27, 35, 35);
    
    [addTextBtn addTarget:self action:@selector(writeText) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:addTextBtn];
}
- (void)writeText
{
    //进入添加糗事页
    WriteMyTextViewController *myTextController = [[WriteMyTextViewController alloc] init];
    myTextController.view.backgroundColor = [UIColor whiteColor];
    myTextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:myTextController animated:YES completion:nil];
}
- (void)setKindOfTabBar
{
    kindOfTabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44+20, kScreemWidth, 35)];
    kindOfTabBar.image = [UIImage imageNamed:@"tabBarbackground"];
    MoveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, kScreemWidth/5, 3)];
    kindOfTabBar.userInteractionEnabled = YES;
    MoveLabel.backgroundColor = [UIColor orangeColor];
    [kindOfTabBar addSubview:MoveLabel];
    //初始化自定义的选中背景
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kScreemWidth/5, 32)];
    _selectView.image = [UIImage imageNamed:@"selectBackGround"];
    [kindOfTabBar addSubview:_selectView];
    
    
    //初始化自定义TabBarItam －－－》UIButton
    int coordinate = 0;
    for (int index = 0; index < 5; ++index) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(coordinate, 0, kScreemWidth/5, 35);
        NSString *namePath = [[NSBundle mainBundle] pathForResource:@"MainViewBarName" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:namePath];
        NSArray *nameArray = [dic objectForKey:@"BarName"];
        NSString *BarItemName = [nameArray objectAtIndex:index];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:BarItemName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        button.tag = index;
        //添加事件监听
        [button addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        [kindOfTabBar addSubview:button];
        coordinate += kScreemWidth/5;
    }
    
    [view addSubview:kindOfTabBar];
}

- (void)changeView:(UIButton *)button
{
    [UIView beginAnimations:nil context:NULL];
    //[UIView setAnimationDuration:0.5];
    _selectView.frame = CGRectMake(button.tag*kScreemWidth/5, 0, kScreemWidth/5, 32);
    MoveLabel.frame = CGRectMake(button.tag*kScreemWidth/5, 32, kScreemWidth/5, 3);
    [UIView commitAnimations];
    //根据按钮点击切换视图
    float XPoint = kScreemWidth*button.tag;
    [_scrollView setContentOffset:CGPointMake(XPoint, 0) animated:YES];
    
    [tempButton setSelected:NO];
    [button setSelected:YES];
    tempButton = button;
    //加载不同的糗事
    NSString *urlString = nil;
    if (button.tag == 0) {
        urlString = SuggestURLString(30,1);
    }else if(button.tag == 1){
        urlString = ImageURLString(30, 1);
    }else if(button.tag == 2){
        urlString = TextURLString(30, 1);
    }else if(button.tag == 3){
        urlString = LastestURLString(30, 1);
    }else if(button.tag == 4){
        urlString = MonthURLString(30, 1);
    }
    [self loadData:urlString tableViewWithTag:button.tag+11];
}
//请求数据
-(void)loadData:(NSString *)urlString tableViewWithTag:(int)Tag
{
    [RequestData requestData:urlString block:^(NSArray *listArr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _dataArray=listArr;
            PullTableView *tableView = (PullTableView *)[self.view viewWithTag:Tag];
            [tableView reloadData];
            
        });
    }];
                      
}

#pragma -mark UIscrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //区分到底是那个类的ScrollView
    if ([scrollView isMemberOfClass:[PullTableView class]]) {
        
    }else{
        _selectView.frame = CGRectMake(scrollView.contentOffset.x/5, 0, kScreemWidth/5, 32);
        MoveLabel.frame = CGRectMake(scrollView.contentOffset.x/5, 32, kScreemWidth/5, 3);

        //加载不同的糗事
        float index = _scrollView.contentOffset.x/kScreemWidth;
        int curentPage;
        NSString *urlString = nil;
        if (index == 0.0) {
            urlString = SuggestURLString(30,1);
            curentPage = 0;
        }else if(index == 1.0){
            urlString = ImageURLString(30, 1);
            curentPage = 1;
        }else if(index == 2.0){
            urlString = TextURLString(30, 1);
            curentPage = 2;
        }else if(index == 3.0){
            urlString = LastestURLString(30, 1);
            curentPage = 3;
        }else if(index == 4.0){
            urlString = MonthURLString(30, 1);
            curentPage = 4;
        }
        [self loadData:urlString tableViewWithTag:curentPage+11];
    } 
}
#pragma -mark UITableView  Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    myCell *cell = [[myCell alloc] init];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor redColor].CGColor;
    //单元格选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置自适应大小
    QiuShi *qiuShi=[[QiuShi alloc]init];
    qiuShi=[_dataArray objectAtIndex:indexPath.row];
    
    //搭建框架
    CGSize textSize=[qiuShi.content sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(kScreemWidth-30, MAXFLOAT) lineBreakMode:UILineBreakModeHeadTruncation];
    cell.textContent.frame=CGRectMake(15, 45, kScreemWidth-30, textSize.height);
    cell.textContent.font = [UIFont systemFontOfSize:fontSize];
    cell.imageContent.frame=CGRectMake(15,45+textSize.height+5, qiuShi.imageWidth, qiuShi.imageHeight);
    cell.imageContent.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageContent.clipsToBounds = YES;
    //给各个项目赋相应的值
    qiuShi=[_dataArray objectAtIndex:indexPath.row];
    if (qiuShi.userName != nil) {
        cell.userNameLabel.text=qiuShi.userName;
    }else{
        cell.userNameLabel.text = @"匿名";
    }
    
    //加载头像按钮图片
    if (qiuShi.userIcon == nil) {
        [cell.userHeadBtn setImage:[UIImage imageNamed:@"thumb_avatar"]forState:UIControlStateNormal];
    }else{
        dispatch_queue_t queue = dispatch_queue_create("imageIcon", NULL);
        dispatch_async(queue, ^{
            NSURL *url = [NSURL URLWithString:qiuShi.userIcon];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [cell.userHeadBtn setImage:img forState:UIControlStateNormal];           
            }); 
        });
    }
    //给图片添加单击事件－－》以放大浏览
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ZoomImageAction:)];
    singleTap.numberOfTapsRequired = 1;
    [cell.imageContent addGestureRecognizer:singleTap];
    
    
    //加载图片
    if(isLoadImage){
        dispatch_queue_t queue = dispatch_queue_create("image", NULL);
        dispatch_async(queue, ^{
            NSURL *url = [NSURL URLWithString:qiuShi.imageURL];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:data];
            dispatch_sync(dispatch_get_main_queue(), ^{
                cell.imageContent.image=img;
            }); 
        });
    }else{
        cell.imageContent.image = [UIImage imageNamed:@"nopic.jpg"];
    }
    
    //[self creatImageURL:qiuShi.imageURL];
    if (qiuShi.userID != nil)
    {
        cell.userHeadBtn.btnTag=qiuShi.userID;
        //给头像button添加事件
        [cell.userHeadBtn addTarget:self action:@selector(userMesAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell.userHeadBtn.enabled = NO;
    }
    cell.textContent.text=qiuShi.content;
    //顶
    cell.upBtn.frame = CGRectMake(20, qiuShi.imageHeight+textSize.height+45+5+10, 20, 20);
    [cell.upBtn setImage:[UIImage imageNamed:@"qiushi_content_like"] forState:UIControlStateNormal];
    [cell.upBtn addTarget:self action:@selector(upAction:) forControlEvents:UIControlEventTouchUpInside];
    //添加事件
    
    cell.upCountLabel.frame = CGRectMake(45, qiuShi.imageHeight+textSize.height+45+5+13, 40, 16);
    cell.upCountLabel.text = [NSString stringWithFormat:@"%d",qiuShi.upCount];
    
    //踩
    cell.downBtn.frame = CGRectMake(85, qiuShi.imageHeight+textSize.height+45+5+10, 20, 20);
    [cell.downBtn setImage:[UIImage imageNamed:@"qiushi_content_unLike"] forState:UIControlStateNormal];
    [cell.downBtn addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.downCountLabel.frame = CGRectMake(107, qiuShi.imageHeight+textSize.height+45+5+13, 40, 16);
    cell.downCountLabel.text = [NSString stringWithFormat:@"%d",qiuShi.downCount];

    //评论
    cell.commentBtn.frame = CGRectMake(kScreemWidth - 75, qiuShi.imageHeight+textSize.height+45+5+10, 20, 20);
    //设置评论按钮的属性
    cell.commentBtn.commentCell = cell;
    cell.commentBtn.btnTag = qiuShi.qiushiID;
    cell.comentCountlabel.frame = CGRectMake(kScreemWidth - 50, qiuShi.imageHeight+textSize.height+45+5+13, 40, 16);
    [cell.commentBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
    cell.comentCountlabel.font = [UIFont systemFontOfSize:13.0];
    cell.comentCountlabel.text = [NSString stringWithFormat:@"%d",qiuShi.commentsCount];
    [cell.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    

    //把大图片给cell的属性
    cell.largeImageString = qiuShi.largeImageURL;
    return cell;
}
- (void)ZoomImageAction:(UITapGestureRecognizer *)tap
{
    UIImageView *imgView =(UIImageView *)[tap view];
    myCell *cell = (myCell *)imgView.superview;

    __block pictureDetailViewController *pictureDetail = [[pictureDetailViewController alloc] init];
    dispatch_queue_t queue = dispatch_queue_create("image", NULL);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:cell.largeImageString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            pictureDetail.imageContent = img;
            
            pictureDetail.scale = 1.0;
            [self presentViewController:pictureDetail animated:YES completion:nil];
            
        }); 
    });
    
}
static int a = 0;
- (void)upAction:(id)sender
{
    if (a%2 == 0) {
        myCell *Cell = (myCell *)[sender superview];
        NSString *upCount = Cell.upCountLabel.text;
        int upNum = [upCount intValue];
        upCount = [NSString stringWithFormat:@"%d",upNum+1];
        Cell.upCountLabel.text = upCount;
        
        NSString *downCount = Cell.downCountLabel.text;
        int downNum = [downCount intValue];
        downCount = [NSString stringWithFormat:@"%d",downNum+1];
        Cell.downCountLabel.text = downCount;
        a++;
    }
}
- (void)downAction:(id)sender
{
    if (a%2 == 1) {
        myCell *Cell = (myCell *)[sender superview];
        NSString *downCount = Cell.downCountLabel.text;
        int downNum = [downCount intValue];
        downCount = [NSString stringWithFormat:@"%d",downNum-1];
        Cell.downCountLabel.text = downCount;
        
        NSString *upCount = Cell.upCountLabel.text;
        int upNum = [upCount intValue];
        upCount = [NSString stringWithFormat:@"%d",upNum-1];
        Cell.upCountLabel.text = upCount;
        a++;
    }
}
- (void)commentAction:(HeadButton *)commentBtn
{
    //创建模态视图，进入糗事评论详细页面
    Switch3DTransition *animation = [[Switch3DTransition alloc] init];
    animation.transitionType = Switch3DTransitionLeft;
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    QiushiDetailViewController *commentDetail = [[QiushiDetailViewController alloc] init];
    commentDetail.detailCell = commentBtn.commentCell;
    commentDetail.detailCell.userInteractionEnabled = NO;
    commentDetail.qiushiId = commentBtn.btnTag;
    [[HMGLTransitionManager sharedTransitionManager] presentModalViewController:commentDetail onViewController:self.tabBarController];
}
- (void)userMesAction:(HeadButton *)button
{
    //创建模态视图，进入作者信息页面
    Switch3DTransition *animation = [[Switch3DTransition alloc] init];
    animation.transitionType = Switch3DTransitionLeft;
    
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    
    UserInformationViewController *userInfo = [[UserInformationViewController alloc] init];
    userInfo.userId=button.btnTag;
    
    [[HMGLTransitionManager sharedTransitionManager] presentModalViewController:userInfo onViewController:self.tabBarController];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QiuShi *qiuShi=[[QiuShi alloc]init];
    qiuShi=[_dataArray objectAtIndex:indexPath.row];
    float imgHeigth=qiuShi.imageHeight;
    CGSize textSize=[qiuShi.content sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(kScreemWidth-30, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    
    return imgHeigth+textSize.height+40+45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建模态视图，进入糗事详细页面
    Switch3DTransition *animation = [[Switch3DTransition alloc] init];
    animation.transitionType = Switch3DTransitionLeft;
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];

    self.detail = [[QiushiDetailViewController alloc] init];
    UITableViewCell *iCell=[[UITableViewCell alloc]init];
    iCell= [tableView cellForRowAtIndexPath:indexPath];
    _detail.detailCell = (myCell *)iCell;
    _detail.detailCell.userInteractionEnabled = NO;
    QiuShi *qiushi=[[QiuShi alloc]init];
    qiushi = [_dataArray objectAtIndex:indexPath.row];
    _detail.qiushiId = qiushi.qiushiID;
    [[HMGLTransitionManager sharedTransitionManager] presentModalViewController:_detail onViewController:self.tabBarController];
}

#pragma mark - PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    if ([pullTableView isMemberOfClass:[UIScrollView class]]) {
        
    }else{
        [self performSelector:@selector(pullRefreshTable) withObject:nil afterDelay:3.0f];
    }
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    if ([pullTableView isMemberOfClass:[UIScrollView class]]) {
        
    }else{
        [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
    }
}
- (void)pullRefreshTable
{
    int currentIndex = _scrollView.contentOffset.x/kScreemWidth;
    
    NSString *urlString = nil;
    if (currentIndex == 0) {
        urlString = SuggestURLString(30,1);
    }else if(currentIndex == 1){
        urlString = ImageURLString(30, 1);
    }else if(currentIndex == 2){
        urlString = TextURLString(30, 1);
    }else if(currentIndex == 3){
        urlString = LastestURLString(30, 1);
    }else if(currentIndex == 4){
        urlString = MonthURLString(30, 1);
    }
    
    [self loadData:urlString tableViewWithTag:currentIndex+11];
    PullTableView *tableView = (PullTableView *)[self.view viewWithTag:11+currentIndex];
    if (!tableView.pullTableIsRefreshing) {
        tableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(pullRefreshTable) withObject:nil afterDelay:2.0f];
    }
    [tableView reloadData];
    
    
    tableView.pullLastRefreshDate = [NSDate date];
    tableView.pullTableIsRefreshing = NO;
    
}
static int page=1;
- (void)loadMoreDataToTable
{
    page ++;
    int currentIndex = _scrollView.contentOffset.x/kScreemWidth;
    
    NSString *urlString = nil;
    if (currentIndex == 0) {
        urlString = SuggestURLString(30,page);
    }else if(currentIndex == 1){
        urlString = ImageURLString(30, page);
    }else if(currentIndex == 2){
        urlString = TextURLString(30, page);
    }else if(currentIndex == 3){
        urlString = LastestURLString(30, page);
    }else if(currentIndex == 4){
        urlString = MonthURLString(30, page);
    }
    PullTableView *tableView = (PullTableView *)[self.view viewWithTag:11+currentIndex];
    [RequestData requestData:urlString block:^(NSArray *arr) {
        loadingArray = [_dataArray arrayByAddingObjectsFromArray:arr];
        dispatch_async(dispatch_get_main_queue(),  ^{
            _dataArray = loadingArray;
            
            [tableView reloadData];
            tableView.pullTableIsLoadingMore = NO;
        });
    }];   
}
@end
