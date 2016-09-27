//
//  myCell.m
//  qiushibaikeProject
//
//  Created by  on 14-9-14.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "myCell.h"

@implementation myCell
@synthesize userHeadBtn = _userHeadBtn,upBtn = _upBtn,downBtn = _downBtn,commentBtn = _commentBtn;
@synthesize userNameLabel = _userNameLabel,upCountLabel = _upCountLabel,comentCountlabel = _comentCountlabel,downCountLabel = _downCountLabel;
@synthesize textContent = _textContent;
@synthesize imageContent = _imageContent;
@synthesize largeImageString = _largeImageString;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubViews];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.userInteractionEnabled = YES;
    }
    return self;
}
//初始化各个属性
- (void)initSubViews
{
    _userHeadBtn = [HeadButton buttonWithType:UIButtonTypeCustom];
    
    
    _upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _commentBtn = [HeadButton buttonWithType:UIButtonTypeCustom];
    
    _userNameLabel = [[UILabel alloc] init];
    _upCountLabel = [[UILabel alloc] init];
    _downCountLabel = [[UILabel alloc] init];
    
    _comentCountlabel = [[UILabel alloc] init];
    
    _textContent = [[UILabel alloc] init];
    
    _imageContent = [[UIImageView alloc] init];
    
    _largeImageString = [[NSString alloc] init];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _userHeadBtn.frame = CGRectMake(15, 5, 30, 30);
    _userHeadBtn.layer.cornerRadius = 12;
    _userHeadBtn.layer.masksToBounds = YES;
    
    _userHeadBtn.layer.borderWidth = 1;
    _userHeadBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    _userNameLabel.frame = CGRectMake(50, 10, 240, 20);
    _upCountLabel.backgroundColor = [UIColor clearColor];
    _upCountLabel.font = [UIFont systemFontOfSize:13.0];
    _downCountLabel.backgroundColor = [UIColor clearColor];
    _downCountLabel.font = [UIFont systemFontOfSize:13.0];
    _userNameLabel.font = [UIFont systemFontOfSize:16.5f];
    _userNameLabel.backgroundColor = [UIColor clearColor];
    _textContent.numberOfLines=0;
    _textContent.backgroundColor = [UIColor clearColor];
    //_textContent.font = [UIFont systemFontOfSize:13.5f];
    _imageContent.userInteractionEnabled = YES;
    _imageContent.backgroundColor = [UIColor clearColor];
    
    _comentCountlabel.backgroundColor = [UIColor clearColor];

    [self addSubview:_userHeadBtn];
    [self addSubview:_userNameLabel];
    [self addSubview:_textContent];
    [self addSubview:_imageContent];
    [self addSubview:_upBtn];
    [self addSubview:_downBtn];
    [self addSubview:_commentBtn];   
    [self addSubview:_upCountLabel];
    [self addSubview:_downCountLabel];
    [self addSubview:_comentCountlabel];
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
