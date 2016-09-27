//
//  RequestComents.m
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "RequestComents.h"
#import "ASIFormDataRequest.h"
#import "QiushiComentsModel.h"
//http://m2.qiushibaike.com/article/88644391/comments?page=1&count=10
@implementation RequestComents
+(void)requestComentsdata:(NSString *)qiushiId block:(qiushiComents)block
{
    NSString *urlString=[NSString stringWithFormat:@"http://m2.qiushibaike.com/article/%@/comments?page=1&count=50",qiushiId];
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
            QiushiComentsModel *qiuShiComent=[[QiushiComentsModel alloc]initWithDictionary:dic];
            [modelsArray addObject:qiuShiComent]; 
        }
        block(modelsArray);

    }];
    [request startAsynchronous];
}

@end
