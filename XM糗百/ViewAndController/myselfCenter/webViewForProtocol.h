//
//  webViewForProtocol.h
//  qiushibaikeProject
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface webViewForProtocol : UIViewController<UIAlertViewDelegate>
{
    UIImageView *myNavBar;
    UIImageView *myTabBar;
    UIWebView *webView;
}
- (void)setNavBar;
- (void)setTabBar;
@end
