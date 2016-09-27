//
//  myCell.h
//  qiushibaikeProject
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButton.h"

@interface myCell : UITableViewCell
@property (nonatomic,retain)HeadButton *upBtn,*downBtn,*commentBtn;
@property (nonatomic,retain)HeadButton *userHeadBtn;
@property (nonatomic,retain)UILabel *userNameLabel,*upCountLabel,*comentCountlabel,*downCountLabel;
@property (nonatomic,retain) UILabel *textContent;
@property (nonatomic,retain) UIImageView *imageContent;
@property (nonatomic,retain) NSString *largeImageString;

- (void)initSubViews;
@end
