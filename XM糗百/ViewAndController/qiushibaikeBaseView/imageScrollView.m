//
//  imageScrollView.m
//  scrollViewDemo1
//
//  Created by  on 14-9-7.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "imageScrollView.h"

@implementation imageScrollView
@synthesize imageView = _imageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumZoomScale = 0.25;
        self.maximumZoomScale = 3.0;
        self.bounces = NO;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];

        //给图片添加双击事件
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomInOrOut:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        
        
    }
    return self;
}
#pragma mark - target Action
- (void)zoomInOrOut:(UIGestureRecognizer *)doubletap
{
    if (self.zoomScale>= 3 || self.zoomScale < 1) {
        [self setZoomScale:1 animated:YES];
    }else{
        CGPoint point = [doubletap locationInView:self];
        [self zoomToRect:CGRectMake(point.x - 40, point.y - 40, 80, 80) animated:YES];
    }
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
@end
