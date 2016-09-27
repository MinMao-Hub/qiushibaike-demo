//
//  ModifyUserInformationView.h
//  qiushibaikeProject
//
//  Created by  on 14-9-30.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ModifyUserInformationViewDelegate<NSObject>
@optional
- (void)backFormerView;
- (void)saveUserInfo;
@end
@interface ModifyUserInformationView : UIView<UITextFieldDelegate> {
    UITextField *ageTextFeild;
    UITextField *sexyTextFeild;
    UITextField *signatureTextFeild;
    UITextField *introduceTextFeild;
    UITextField *locationTextFeild;
    UITextField *hobbyTextFeild;
    
    UIScrollView *_scrollViewForscroll;
}
@property (nonatomic,strong) id<ModifyUserInformationViewDelegate> delegate;
@property (strong, nonatomic) UITextField *ageTextFeild;
@property (strong, nonatomic) UITextField *sexyTextFeild;
@property (strong, nonatomic) UITextField *signatureTextFeild;
@property (strong, nonatomic) UITextField *introduceTextFeild;
@property (strong, nonatomic) UITextField *locationTextFeild;
@property (strong, nonatomic) UITextField *hobbyTextFeild;
@property (strong, nonatomic) UIScrollView *scrollViewForscroll;
- (void)setNavBar;
@end
