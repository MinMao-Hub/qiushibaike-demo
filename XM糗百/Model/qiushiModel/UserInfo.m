//
//  UserInfo.m
//  qiushibaikeProject
//
//  Created by  on 14-9-21.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"
#import "ASIFormDataRequest.h"

@implementation UserInfo
@synthesize userName=_userName,
            signature=_signature,
            astrology=_astrology,
            gender=_gender,
            hobby=_hobby,
            location=_location,
            introduce=_introduce,
            mobile_brand=_mobile_brand,
            userIcon=_userIcon,
            job = _job,
            haunt = _haunt,
            hometown = _hometown;

@synthesize age=_age,
            qb_age = _qb_age,
            qs_count = _qs_count;
@synthesize createTime=_createTime;
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _userName = [dictionary objectForKey:@"login"];
        _signature = [dictionary objectForKey:@"signature"];
        _astrology = [dictionary objectForKey:@"astrology"];
        _age = [[dictionary objectForKey:@"age"] intValue];
        _gender = [dictionary objectForKey:@"gender"];
        _hobby = [dictionary objectForKey:@"hobby"];
        _location = [dictionary objectForKey:@"location"];
        _introduce = [dictionary objectForKey:@"introduce"];
        _createTime = [dictionary objectForKey:@"created_at"];
        _mobile_brand = [dictionary objectForKey:@"mobile_brand"];
        _qb_age = [[dictionary objectForKey:@"qb_age"] integerValue];
        _qs_count = [[dictionary objectForKey:@"qs_cnt"] integerValue];
        _job = [dictionary objectForKey:@"job"];
        userID = [[dictionary objectForKey:@"uid"] stringValue];
        _haunt = [dictionary objectForKey:@"haunt"];
        _hometown = [dictionary objectForKey:@"hometown"];
        NSString *headString=nil;
        
        if (userID.length == 7) {
            headString=[userID substringToIndex:3];
        }else if (userID.length == 8){
            headString=[userID substringToIndex:4];
        }else if (userID.length == 9){
            headString=[userID substringToIndex:5];
        }else if (userID.length == 10){
            headString=[userID substringToIndex:6];
        }
        if ([[dictionary objectForKey:@"icon"] length] != 0) {
            NSString *newUserURL = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@",headString,userID,[dictionary objectForKey:@"icon"]];
            NSURL *url=[NSURL URLWithString:newUserURL];
            __weak ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL: url];
            request.requestMethod=@"GET";
            request.timeOutSeconds=60;
            [request startSynchronous];
            NSError *error=request.error;
            if(error==nil)
            {
                NSData *data= request.responseData;
                UIImage *imageHead=[UIImage imageWithData:data];
                _userIcon=imageHead;
            }
        }else{
            _userIcon=[UIImage imageNamed:@"nopic.jpg"];
        }
         
        
    }
    return self;
    
}


@end
