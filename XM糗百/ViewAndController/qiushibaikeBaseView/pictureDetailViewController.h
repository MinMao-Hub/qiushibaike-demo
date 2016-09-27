//
//  pictureDetailViewController.h
//  qiushibaikeProject
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pictureDetailViewController : UIViewController<UIGestureRecognizerDelegate>
{
    CGFloat roation;
    CGFloat _scale;
}
@property (nonatomic,retain)UIImage *imageContent;
@property (nonatomic,assign)CGFloat scale;
@end
