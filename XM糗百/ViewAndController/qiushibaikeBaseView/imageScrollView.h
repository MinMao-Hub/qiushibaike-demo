//
//  imageScrollView.h
//  scrollViewDemo1
//
//  Created by  on 14-9-7.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageScrollView : UIScrollView<UIScrollViewDelegate>
{
    UIImageView *_imageView;
}
@property (nonatomic,retain)UIImageView *imageView;
@end
