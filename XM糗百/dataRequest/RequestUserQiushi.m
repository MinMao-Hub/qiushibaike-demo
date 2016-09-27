//
//  RequestUserQiushi.m
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "RequestUserQiushi.h"
#import "QiuShi.h"
//http://m2.qiushibaike.com/user/19349117/articles?page=1&count=30&rqcnt=6
@implementation RequestUserQiushi

+(void)requestUserQiushi:(NSString *)userId block:(userQiushi)block
{
    NSString *urlString=[NSString stringWithFormat:@"http://m2.qiushibaike.com/user/%@/articles?page=1&count=30",userId];
    NSURL *url=[NSURL URLWithString:urlString];
    __weak ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    request.requestMethod=@"GET";
    request.timeOutSeconds=60;
    [request setCompletionBlock:^{
        NSData *data= request.responseData;
         NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr=[dict objectForKey:@"items"];
        NSMutableArray *modelsArray=[NSMutableArray array];
        for (NSDictionary *dic in arr) {
            QiuShi *qiuShi=[[QiuShi alloc]initWithDictionary:dic];
            [modelsArray addObject:qiuShi]; 
        }
        block(modelsArray);
        
    }];
    [request startAsynchronous];
    
}

@end
