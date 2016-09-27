//
//  DetailCell.m
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell
@synthesize comentLabel = _comentLabel;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _comentLabel = [[UILabel alloc] init];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(60, 10, 220, 16);
    
    self.imageView.frame = CGRectMake(12, 10, 40, 40);
    self.imageView.layer.cornerRadius = 10;
    self.imageView.layer.masksToBounds = YES;
    
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.borderColor = [UIColor redColor].CGColor;
    _comentLabel.font = [UIFont boldSystemFontOfSize:14];

    _comentLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_comentLabel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
