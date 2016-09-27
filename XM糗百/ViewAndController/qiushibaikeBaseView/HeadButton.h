//
//  HeadButton.h
//  qiushibaikeProject
//
//  Created by  on 14-9-19.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myCell;
@interface HeadButton : UIButton
@property(nonatomic,retain)NSString *btnTag;
@property (nonatomic,retain) myCell *commentCell;
@end
