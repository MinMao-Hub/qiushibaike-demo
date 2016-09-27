//
//  RquestUserData.m
//  QiushiBaike
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "RquestUserData.h"
#import "UserInfo.h"
//http://nearby.qiushibaike.com/user/5860828/detail?
@implementation RquestUserData
+(void)requestUserData:(NSString *)userId block:(userData)block
{
    NSString *urlString=[NSString stringWithFormat:@"http://nearby.qiushibaike.com/user/%@/detail?",userId];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *respomse, NSData *data, NSError *error) {
        if(error!=nil)
        {
            NSLog(@"网络请求出错--%@",[error localizedDescription]);
            return;
        }
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dicUserData=[NSDictionary dictionaryWithDictionary:[dict objectForKey:@"userdata"]];
        NSMutableArray *modelsArray=[NSMutableArray array];
        UserInfo *userinfo=[[UserInfo alloc]initWithDictionary:dicUserData];
        [modelsArray addObject:userinfo];
        block(modelsArray);
        
    }];
}

@end
