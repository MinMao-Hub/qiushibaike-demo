//
//  pictureDetailViewController.m
//  qiushibaikeProject
//
//  Created by  on 14-9-28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "pictureDetailViewController.h"
#import "imageScrollView.h"
@implementation pictureDetailViewController
{
    imageScrollView *scrollView;
}
@synthesize imageContent = _imageContent;
@synthesize scale = _scale;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    scrollView = [[imageScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreemWidth, kScreemHeight)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.imageView.image = _imageContent;
    
    [self.view addSubview:scrollView];
    
    
    NSArray *array = [NSArray arrayWithObjects:@"rotate_left",@"rotate_right",@"zoom_in",@"zoom_out",nil];
    for (int i=0; i<[array count]; i++) 
    {
        UIImage *normal = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[array objectAtIndex:i]]];
        UIImage *active = [[UIImage imageNamed:@"imageviewer_toolbar_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake((kScreemWidth - [array count]* 52)/2+52*i,kScreemHeight-60,52,40)];
        [btn setImage:normal forState:UIControlStateNormal];
        [btn setBackgroundImage:active forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        [self.view addSubview:btn];
        
    }
    
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setFrame:CGRectMake(10,25,90,35)];
    [backbtn setImageEdgeInsets:UIEdgeInsetsMake(0,2,0,0)];
    [backbtn setTitleEdgeInsets:UIEdgeInsetsMake(2,-2,0,0)];
    [backbtn setImage:[UIImage imageNamed:@"imageviewer_return.png"] forState:UIControlStateNormal];
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [backbtn setBackgroundImage:[[UIImage imageNamed:@"imageviewer_toolbar_background.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [backbtn setTag:4];
    [backbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [savebtn setFrame:CGRectMake(kScreemWidth - (90 + 10),25,90,35)];
    [savebtn setImageEdgeInsets:UIEdgeInsetsMake(0,2,0,0)];
    [savebtn setTitleEdgeInsets:UIEdgeInsetsMake(2,-2,0,0)];
    [savebtn setImage:[UIImage imageNamed:@"imageviewer_save.png"] forState:UIControlStateNormal];
    [savebtn setTitle:@"保存" forState:UIControlStateNormal];
    [savebtn setBackgroundImage:[[UIImage imageNamed:@"imageviewer_toolbar_background.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [savebtn setTag:5];
    [savebtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savebtn];
    
    [scrollView.imageView setUserInteractionEnabled:YES];
    UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panRcognize setMinimumNumberOfTouches:1];
    panRcognize.delegate=self;
    [panRcognize setEnabled:YES];
    [panRcognize delaysTouchesEnded];
    [panRcognize cancelsTouchesInView];
    
    UIPinchGestureRecognizer *pinchRcognize=[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [pinchRcognize setEnabled:YES];
    [pinchRcognize delaysTouchesEnded];
    [pinchRcognize cancelsTouchesInView];
    
    UIRotationGestureRecognizer *rotationRecognize=[[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    [rotationRecognize setEnabled:YES];
    [rotationRecognize delaysTouchesEnded];
    [rotationRecognize cancelsTouchesInView];
    rotationRecognize.delegate=self;
    pinchRcognize.delegate=self;
    
    [scrollView.imageView addGestureRecognizer:rotationRecognize];
    [scrollView.imageView addGestureRecognizer:panRcognize];
    [scrollView.imageView addGestureRecognizer:pinchRcognize];
    
}
- (void)viewDidLoad
{
    //if (kVersion >= 7.0f) {
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //}
}
-(void) BtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:  //向左
        {
            [UIView animateWithDuration:0.5f animations:^{
                roation -=M_PI_2;
                scrollView.imageView.transform = CGAffineTransformMakeRotation(roation);
            }];
        }
            break;
        case 1:  //向右
        {
            
            [UIView animateWithDuration:0.5f animations:^{
                roation +=M_PI_2;
                scrollView.imageView.transform = CGAffineTransformMakeRotation(roation);
            }];
        }
            break;
        case 2:  //放大
        {
            [UIView animateWithDuration:0.5f animations:^{
                _scale *= 1.5;
                scrollView.imageView.transform = CGAffineTransformMakeScale(_scale,_scale);
            }];
        }
            break;
        case 3:  //缩小
        {
            [UIView animateWithDuration:0.5f animations:^{
                _scale /= 1.5;
                scrollView.imageView.transform = CGAffineTransformMakeScale(_scale,_scale);
            }];
        }
            break;
        case 4://返回
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 5://保存.
        {
            //调用方法保存到相册的代码  
            UIImageWriteToSavedPhotosAlbum(scrollView.imageView.image, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);  
            
        }
            break;
        default:
            break;
    }
}

//实现类中实现  
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo 
{  
    NSString *message;  
    NSString *title;  
    if (!error) {  
        title = @"成功提示";  
        message = [NSString stringWithFormat:@"成功保存到相冊"];  
    } else {  
        title = @"失败提示";  
        message = [error description];  
    }  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title  
                                                    message:message  
                                                   delegate:nil  
                                          cancelButtonTitle:@"知道了"  
                                          otherButtonTitles:nil];  
    [alert show];   
}  

/*   
 *  移动图片处理的函数
 *  @recognizer 移动手势
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
}
/*
 * handPinch 缩放的函数
 * @recognizer UIPinchGestureRecognizer 手势识别器
 */
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer{
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    
    recognizer.scale = 1;
    
}

/*
 * handleRotate 旋转的函数
 * recognizer UIRotationGestureRecognizer 手势识别器
 */
- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}
@end
