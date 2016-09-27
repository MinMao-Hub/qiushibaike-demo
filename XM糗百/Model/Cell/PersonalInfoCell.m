//
//  PersonalInfoCell.m
//  qiushibaikeProject
//
//  Created by  on 14-9-21.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "PersonalInfoCell.h"

@implementation PersonalInfoCell
@synthesize label1=_label1,label2 = _label2,label3 = _label3;
@synthesize imgView=_imgView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label1=[[UILabel alloc]init];
        _label2=[[UILabel alloc]init];
        _label3=[[UILabel alloc]init];
        _imgView=[[UIImageView alloc]init];
    }
    return self;
}
-(void)layoutSubviews
{
    _label2.textColor=[UIColor darkGrayColor];
    _label2.frame = CGRectMake(10, 0, 85, 36);
    _label2.font = [UIFont systemFontOfSize:15.f];
    _label3.textColor = [UIColor blackColor];
    _label3.numberOfLines = 0;
    _label3.font = [UIFont systemFontOfSize:15.f];
    _label1.font = [UIFont systemFontOfSize:15.f];
    
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:_label1];
    [self.contentView addSubview:_label2];
    [self.contentView addSubview:_label3];
    [self.contentView addSubview:_imgView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
