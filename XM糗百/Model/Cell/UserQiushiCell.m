//
//  UserQiushiCell.m
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "UserQiushiCell.h"

@implementation UserQiushiCell
@synthesize upBtn = _upBtn,downBtn = _downBtn,commentBtn = _commentBtn;
@synthesize upCountLabel = _upCountLabel,comentCountlabel = _comentCountlabel,downCountLabel = _downCountLabel;
@synthesize textContent = _textContent;
@synthesize imageContent = _imageContent;
@synthesize userNameLabel=_userNameLabel;
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
    _upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _downBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
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
    _upCountLabel.backgroundColor = [UIColor clearColor];
    _upCountLabel.font = [UIFont systemFontOfSize:13.0];
    _downCountLabel.backgroundColor = [UIColor clearColor];
    _downCountLabel.font = [UIFont systemFontOfSize:13.0];
    _textContent.numberOfLines=0;
    _textContent.backgroundColor = [UIColor clearColor];
    _textContent.font = [UIFont systemFontOfSize:13.5f];
    
    _imageContent.backgroundColor = [UIColor clearColor];
    
    _comentCountlabel.backgroundColor = [UIColor clearColor];
    

    [self.contentView addSubview:_upBtn];
    [self.contentView addSubview:_downBtn];
    [self.contentView addSubview:_commentBtn];
    [self.contentView addSubview:_upCountLabel];
    [self.contentView addSubview:_downCountLabel];
    [self.contentView addSubview:_comentCountlabel];
    [self.contentView addSubview:_textContent];
    [self.contentView addSubview:_imageContent];
}- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
