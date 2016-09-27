//
//  MyselfInfomationViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-29.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "MyselfInfomationViewController.h"
#import "PersonalInfoCell.h"
#import "ModifyUserInformationView.h"
#import "UserInfoModel.h"
#import "UserDataManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation MyselfInfomationViewController
{
    NSString *_signature;
    NSData *_headImageName;
    UserInfoModel *model;
    UIImageView *imageView;
}
@synthesize userNameLabel = _userNameLabel;
@synthesize userNameForFront = _userNameForFront;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    _listArray1 = [NSArray arrayWithObjects:@"年龄性别",@"兴趣爱好",@"常出没地",@"个人说明",@"注册时间",@"爪机品牌", nil];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setNavBar];
    [self setMyTableView];
    [self setUserInfoFromCoreData];
    
    [self setMyHeaderView];
    
    //创建修改用户信息页面
    modifyView = [[ModifyUserInformationView alloc] initWithFrame:CGRectMake(kScreemWidth, kScreemHeight, kScreemWidth, kScreemHeight)];
    modifyView.backgroundColor = [UIColor whiteColor];
    modifyView.frame = CGRectMake(-kScreemWidth, kScreemHeight, kScreemWidth, kScreemHeight);
    modifyView.delegate = self;
    [self.view addSubview:modifyView];
    
    //设置原来的数据
    modifyView.ageTextFeild.text = model.age;
    modifyView.sexyTextFeild.text = model.sexy;
    modifyView.introduceTextFeild.text = model.introduce;
    modifyView.signatureTextFeild.text = model.signature;
    modifyView.locationTextFeild.text = model.location;
    modifyView.hobbyTextFeild.text = model.hobby;
    
}
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
}
#pragma -mark  "调用数据库，查询用户个人信息"
- (void)setUserInfoFromCoreData
{
    //注册时间(取当前时间)
    NSDate *registerDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [formatter stringFromDate:registerDate];
    
    //调用数据库  查找所有数据
    NSArray *userInfoArr = [[UserDataManager shareUserDataManager] findModifyUser:_userNameForFront];
    model = [userInfoArr lastObject];
    //个性签名
    _signature = model.signature;
    //头像
    _headImageName = model.userIcon;
    //表格信息数组
    _listArray2 = [NSArray arrayWithObjects:model.age,model.sexy,model.hobby,model.location,model.introduce,time,@"iPhone6 plus", nil];
    
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
    titleLabel.text = @"我的主页";
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
    
    //添加编辑按钮
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(self.view.frame.size.width - 50, 27, 30, 30);
    [editBtn setImage:[UIImage imageNamed:@"navigationbar_compose_highlighted@2x"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editingMyInfo:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:editBtn];
}
- (void)backHomeAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setMyHeaderView
{
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kScreemWidth, 120)];
    imageView.image=[UIImage imageNamed:@"user_info_topImage"];
    imageView.userInteractionEnabled = YES;
    //头像
    headIcon=[[UIImageView alloc]initWithFrame:CGRectMake(20, 55, 50, 50)];
    //设置头像图片
    headIcon.image = [UIImage imageWithData:_headImageName];
    headIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    //设置边框
    headIcon.layer.borderColor = [UIColor redColor].CGColor;
    headIcon.layer.borderWidth = 2;
    [imageView addSubview:headIcon];
    
    //对头像添加单击手势，调出相册或相机，设置头像图片
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapHeaderImage:)];
    headIcon.userInteractionEnabled = YES;
    [headIcon addGestureRecognizer:singleTap];
    headIcon.contentMode = UIViewContentModeScaleAspectFill;
    headIcon.clipsToBounds = YES;
    [self.view addSubview:imageView];
    //昵称
    _userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 57, 245, 20)];
    _userNameLabel.backgroundColor=[UIColor clearColor];
    _userNameLabel.font = [UIFont systemFontOfSize:16.0f];
    _userNameLabel.text = _userNameForFront;
    //个性签名
    signatureTextView=[[UILabel alloc]initWithFrame:CGRectMake(75, 80, 200, 40)];
    signatureTextView.backgroundColor=[UIColor clearColor];
    signatureTextView.text = _signature;
    signatureTextView.textColor = [UIColor blackColor];
    signatureTextView.font = [UIFont systemFontOfSize:13.0f];
    signatureTextView.numberOfLines = 0;
    [imageView addSubview:_userNameLabel];
    [imageView addSubview:signatureTextView];
    //个人简介
    UIImageView *myImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 164+20, kScreemWidth, 35)];
    myImageView.image=[UIImage imageNamed:@"tabBar"];
    [self.view addSubview:myImageView];
    myImageView.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, 32)];
    
    label.text = @"个人简介";
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:20.0f];
    label.textAlignment = NSTextAlignmentCenter;
    [myImageView addSubview:label];
    
    UILabel *sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, kScreemWidth, 3)];
    sepLabel.backgroundColor = [UIColor orangeColor];
    [myImageView addSubview:sepLabel];
    
}
- (void)singleTapHeaderImage:(UIGestureRecognizer *)tap
{
    //调出相册或相机，选取图片，设置头像
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择头像" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册选取" otherButtonTitles:@"相机拍摄", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}
#pragma UIActionSheet  Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = (id)self;
    if (buttonIndex == 0) {
        //调出相册
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:ipc animated:YES completion:NULL];
    }else if(buttonIndex == 1){
        //调出相机
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];//调出前置摄像头
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:@"提示" 
                                  message:@"没有摄像头！" 
                                  delegate:nil 
                                  cancelButtonTitle:@"确定" 
                                  otherButtonTitles: nil];
            [alert show];
            return;
        }
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.allowsEditing = YES;//编辑功能开
        [self presentViewController:ipc animated:YES completion:NULL];
    }else{
        //取消
    }
}
#pragma -mark  UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    headIcon.image = image;

    NSData *imagedata = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        imagedata = UIImageJPEGRepresentation(image, 1);
    }else{
        imagedata = UIImagePNGRepresentation(image);
    }

    //将图片存入数据库
    UserInfoModel *modelForChangeHeadIcon = [[UserInfoModel alloc]init];
    modelForChangeHeadIcon.userName = _userNameForFront;
    
    modelForChangeHeadIcon.userIcon = imagedata;

    modelForChangeHeadIcon.hobby = model.hobby;

    modelForChangeHeadIcon.age = model.age;

    modelForChangeHeadIcon.sexy = model.sexy;

    modelForChangeHeadIcon.introduce = model.introduce;

    modelForChangeHeadIcon.signature = model.signature;

    modelForChangeHeadIcon.location = model.location;
    
    [[UserDataManager shareUserDataManager] updataData:modelForChangeHeadIcon];

    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
//创建表视图，管理个人信息
- (void)setMyTableView
{
    //创建myInfoTableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 199+20, kScreemWidth, kScreemHeight-20-199) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //tableView.bounces = NO;
    _tableView.rowHeight = (kScreemHeight-20-199)/_listArray1.count;
    [self.view addSubview:_tableView];
}
- (void)editingMyInfo:(UIButton *)sender
{
    //编辑个人资料
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    modifyView.frame = CGRectMake(0, 0, kScreemWidth, kScreemHeight-20);
    
    [UIView commitAnimations];
}
#pragma mark - tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray1.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    //用户信息表
    PersonalInfoCell *cell= [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.label2.text = [_listArray1 objectAtIndex:indexPath.row];
    
    
    if (indexPath.row == 0) {
        cell.label3.frame = CGRectMake(100, 0, 25, 36);
        cell.label3.font = [UIFont systemFontOfSize:11.0f];
        cell.label3.text = [_listArray2 objectAtIndex:indexPath.row];
        cell.label1.frame=CGRectMake(160, 0, 70, 36);
        NSArray *astrologys = [NSArray arrayWithObjects:@"天秤座",@"处女座",@"射手座", @"双子座",@"巨蟹座",@"水瓶座",@"双鱼座",@"狮子座",@"摩羯座",@"白羊座",@"天蝎座",@"金牛座", nil];
        cell.label1.text = [astrologys objectAtIndex:arc4random_uniform(12)];
        cell.imgView.frame = CGRectMake(125, 8, 20, 20);
        //性别
        if ([[_listArray2 objectAtIndex:indexPath.row+1] isEqualToString:@"女"]) {
            cell.imgView.image = [UIImage imageNamed:@"Female"];
        }else{
            cell.imgView.image = [UIImage imageNamed:@"Male"];
        }
    }else{
        cell.label3.frame = CGRectMake(100, 0, 200, 36);
        cell.label3.text = [_listArray2 objectAtIndex:indexPath.row+1];
    }
    return cell;
}
#pragma ModifyUserInformationDelegate
- (void)backFormerView
{
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.7];
    modifyView.frame = CGRectMake(-kScreemWidth, kScreemHeight-20, kScreemWidth, kScreemHeight-20);
    [UIView commitAnimations];
    
}
- (void)saveUserInfo
{
    //如果不进行修改，则不做保存处理
    if ([modifyView.hobbyTextFeild.text isEqualToString: model.hobby] && [modifyView.ageTextFeild.text isEqualToString: model.age] && [modifyView.sexyTextFeild.text isEqualToString: model.sexy] && [modifyView.introduceTextFeild.text isEqualToString: model.introduce] && [modifyView.signatureTextFeild.text isEqualToString: model.signature] && [modifyView.locationTextFeild.text isEqualToString: model.location]) {
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle:@"提示" 
                              message:@"你还没有修改信息！" 
                              delegate:self 
                              cancelButtonTitle:@"确定" 
                              otherButtonTitles: nil];
        [alert show];
        
        [UIView beginAnimations:@"Animation" context:@"textField"];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        modifyView.scrollViewForscroll.contentSize = CGSizeMake(kScreemWidth, kScreemHeight-20-44);
        [self.view endEditing:YES];
        [UIView commitAnimations];
        return;
    }
    
    UserInfoModel *modelForChange = [[UserInfoModel alloc]init];
    modelForChange.userName = _userNameForFront;
    modelForChange.userIcon = model.userIcon;
    //兴趣爱好
    if ([modifyView.hobbyTextFeild.text length] == 0) {
        modelForChange.hobby = @"暂未填写";
    }else{
        modelForChange.hobby = modifyView.hobbyTextFeild.text;
    }
    //年龄
    if ([modifyView.ageTextFeild.text length] == 0) {
        modelForChange.age = @"暂未填写";
    }else{
        modelForChange.age = modifyView.ageTextFeild.text;
    }
    //性别
    if ([modifyView.sexyTextFeild.text length] == 0) {
        modelForChange.sexy = @"暂未填写";
    }else{
        modelForChange.sexy = modifyView.sexyTextFeild.text;
    }
    //个人说明
    if ([modifyView.introduceTextFeild.text length] == 0) {
        modelForChange.introduce = @"暂未填写";
    }else{
        modelForChange.introduce = modifyView.introduceTextFeild.text;
    }
    //个性签名
    if ([modifyView.signatureTextFeild.text length] == 0) {
        modelForChange.signature = @"暂未填写";
    }else{
        modelForChange.signature = modifyView.signatureTextFeild.text;
    }
    //常出没地
    if ([modifyView.locationTextFeild.text length] == 0) {
        modelForChange.location = @"暂未填写";
    }else{
        modelForChange.location = modifyView.locationTextFeild.text;
    }
    
    [[UserDataManager shareUserDataManager] updataData:modelForChange];
    
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"提示" 
                          message:@"修改成功！！！" 
                          delegate:self 
                          cancelButtonTitle:@"确定" 
                          otherButtonTitles: nil];
    
    [alert show];
    
    //重新加载数据设置用户信息
    [self setUserInfoFromCoreData];
    //更新头像和个性签名
    signatureTextView.text = _signature;
    headIcon.image = [UIImage imageWithData:_headImageName];
    
    [_tableView reloadData];
    
    [UIView beginAnimations:@"Animation" context:@"textField"];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    modifyView.scrollViewForscroll.contentSize = CGSizeMake(kScreemWidth, kScreemHeight-20-44);
    [self.view endEditing:YES];
    [UIView commitAnimations];
}
@end
