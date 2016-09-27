//
//  ModifyUserInformationView.m
//  qiushibaikeProject
//
//  Created by  on 14-9-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "ModifyUserInformationView.h"
@implementation ModifyUserInformationView
@synthesize ageTextFeild;
@synthesize sexyTextFeild;
@synthesize signatureTextFeild;
@synthesize introduceTextFeild;
@synthesize locationTextFeild;
@synthesize hobbyTextFeild;
@synthesize scrollViewForscroll = _scrollViewForscroll;
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor grayColor];
        [self setNavBar];

        NSArray *labelNames = [NSArray arrayWithObjects:@"年龄",@"性别",@"个性签名",@"个人说明",@"常出没地",@"兴趣爱好", nil];
        
        _scrollViewForscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.frame.size.width
                                                                              , 500-20)];
        _scrollViewForscroll.contentSize = CGSizeMake(self.frame.size.width, 500-20-44);
        _scrollViewForscroll.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_scrollViewForscroll];
        for(int i= 0;i<6 ;i++)
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 20+i*60+8+10, 65, 20)];
            label.tag = 100+i;
            label.font = [UIFont systemFontOfSize:15];
            label.text = [labelNames objectAtIndex:i];
            [_scrollViewForscroll addSubview:label];
            
        }
        self.ageTextFeild = [[UITextField alloc]initWithFrame:CGRectMake(75, 20+10, self.frame.size.width - 90, 35)];
        self.ageTextFeild.borderStyle = UITextBorderStyleLine;
        self.ageTextFeild.returnKeyType = UIReturnKeyDone;
        self.ageTextFeild.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.ageTextFeild.delegate = self;
        [_scrollViewForscroll addSubview:ageTextFeild];
        
        self.sexyTextFeild = [[UITextField alloc]initWithFrame:CGRectMake(75, 20+40+20+10, self.frame.size.width - 90, 35)];
        self.sexyTextFeild.borderStyle = UITextBorderStyleLine;
        self.sexyTextFeild.returnKeyType = UIReturnKeyDone;
        self.sexyTextFeild.delegate = self;
        self.sexyTextFeild.clearButtonMode =UITextFieldViewModeWhileEditing;
        [_scrollViewForscroll addSubview:sexyTextFeild];
        
        self.signatureTextFeild = [[UITextField alloc]initWithFrame:CGRectMake(75, 20+80+30+20, self.frame.size.width - 90, 35)];
        self.signatureTextFeild.borderStyle = UITextBorderStyleLine;
        self.signatureTextFeild.returnKeyType = UIReturnKeyDone;
        self.signatureTextFeild.delegate = self;
        self.signatureTextFeild.clearButtonMode =UITextFieldViewModeWhileEditing;
        [_scrollViewForscroll addSubview:signatureTextFeild];
        
        self.introduceTextFeild = [[UITextField alloc]initWithFrame:CGRectMake(75, 20+120+40+30, self.frame.size.width - 90, 35)];
        self.introduceTextFeild.borderStyle = UITextBorderStyleLine;
        self.introduceTextFeild.returnKeyType = UIReturnKeyDone;
        self.introduceTextFeild.delegate = self;
        self.introduceTextFeild.clearButtonMode =UITextFieldViewModeWhileEditing;
        [_scrollViewForscroll addSubview:introduceTextFeild];
        
        self.locationTextFeild = [[UITextField alloc]initWithFrame:CGRectMake(75, 20+160+50+40, self.frame.size.width - 90, 35)];
        self.locationTextFeild.borderStyle = UITextBorderStyleLine;
        self.locationTextFeild.returnKeyType = UIReturnKeyDone;
        self.locationTextFeild.delegate = self;
        self.locationTextFeild.clearButtonMode =UITextFieldViewModeWhileEditing;
        [_scrollViewForscroll addSubview:locationTextFeild];
        
        self.hobbyTextFeild = [[UITextField alloc]initWithFrame:CGRectMake(75, 20+200+60+50, self.frame.size.width - 90, 35)];
        self.hobbyTextFeild.borderStyle = UITextBorderStyleLine;
        self.hobbyTextFeild.returnKeyType = UIReturnKeyDone;
        self.hobbyTextFeild.delegate = self;
        self.hobbyTextFeild.clearButtonMode =UITextFieldViewModeWhileEditing;
        [_scrollViewForscroll addSubview:hobbyTextFeild];

    }
    return self;
}
- (void)setNavBar
{
    //添加导航栏
    UIImageView *myNavBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
    myNavBar.userInteractionEnabled = YES;
    myNavBar.image = [UIImage imageNamed:@"writeText_nav_bg"];
    myNavBar.backgroundColor = [UIColor purpleColor];
    [self addSubview:myNavBar];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 140, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"修改个人信息";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [myNavBar addSubview:titleLabel];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"writeText_nav_bg"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(5, 27, 40, 30);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:backButton];
    
    //添加编辑按钮
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(self.frame.size.width -50, 27, 40, 30);
    [editBtn setBackgroundImage:[UIImage imageNamed:@"writeText_nav_bg"] forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBar addSubview:editBtn];
}
- (void)saveButton:(UIButton *)sender {
    [self.delegate saveUserInfo];
}

- (void)backButton:(UIButton *)sender {
    [self endEditing:YES];
    [self.delegate backFormerView];
}
#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView beginAnimations:@"Animation" context:@"textField"];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    _scrollViewForscroll.contentSize = CGSizeMake(self.frame.size.width, 500-20-44);
    [textField resignFirstResponder];
    [UIView commitAnimations];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"Animation" context:@"textField"];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    _scrollViewForscroll.contentSize = CGSizeMake(self.frame.size.width, 500-20-44+260);
    
    [UIView commitAnimations];
    
}
@end
