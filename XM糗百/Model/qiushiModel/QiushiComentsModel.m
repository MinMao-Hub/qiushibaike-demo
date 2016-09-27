//
//  QiushiComentsModel.m
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "QiushiComentsModel.h"
#import "ASIFormDataRequest.h"

@implementation QiushiComentsModel
@synthesize content=_content,userName=_userName,userId=_userId,userIcon=_userIcon;
@synthesize floor=_floor;
@synthesize iconImage;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    _content=[dictionary objectForKey:@"content"];
    _floor=[[dictionary objectForKey:@"floor"]intValue];
    
    NSDictionary *user=[dictionary objectForKey:@"user"];
    _userName=[user objectForKey:@"login"];
    _userId=[[user objectForKey:@"id"] stringValue];
    
        NSString *headString=nil;
        if (_userId.length == 7) {
            headString = [_userId substringToIndex:3];
        }else if (_userId.length == 8){
            headString = [_userId substringToIndex:4];
        }else if (_userId.length == 9){
            headString = [_userId substringToIndex:5];
        }else if (_userId.length == 10){
            headString = [_userId substringToIndex:6];
        }
    
        if ((NSNull *)[user objectForKey:@"icon"] != [NSNull null]) {
            NSString *newUserURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@",headString,_userId,[user objectForKey:@"icon"]];
            self.userIcon=newUserURL;
            NSURL *url=[NSURL URLWithString:newUserURL];
            __weak ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
            request.requestMethod=@"GET";
            request.timeOutSeconds=60;
            [request setCompletionBlock:^{
                NSData *data= request.responseData;
                UIImage *imageHead=[UIImage imageWithData:data];
                   self.iconImage=imageHead;
                            }];
            if ([[user objectForKey:@"icon"] length] != 0) {
                [request startAsynchronous];
            }else{
                self.iconImage=[UIImage imageNamed:@"nopic.jpg"];
            }
        }else{
            self.iconImage=[UIImage imageNamed:@"nopic.jpg"];
        }
    
    return self;
}

@end
