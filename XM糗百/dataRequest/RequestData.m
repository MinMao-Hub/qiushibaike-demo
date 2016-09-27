//
//  RequestData.m
//  QiushiBaike
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "RequestData.h"
#import "QiuShi.h"
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"

@implementation RequestData
+(void)requestData:(NSString *)urlString block:(FinishData)block
{
    NSURL *url=[NSURL URLWithString:urlString];
   __weak ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    //隐藏状态栏中的风火轮
    [ASIFormDataRequest setShouldUpdateNetworkActivityIndicator:NO];
    request.requestMethod=@"GET";
    request.timeOutSeconds=60;
    
    //设置缓存
    NSString *cachePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    ASIDownloadCache *cache =[ASIDownloadCache sharedCache];
    //设置缓存路径
    [cache setStoragePath:cachePath];
    cache.defaultCachePolicy=ASIOnlyLoadIfNotCachedCachePolicy;
    request .cacheStoragePolicy=ASICacheForSessionDurationCacheStoragePolicy;
    request.downloadCache=cache;
    
    [request setCompletionBlock:^{
        NSData *data= request.responseData;
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         NSArray *listArr=[NSArray arrayWithArray:[dict objectForKey:@"items"]];
        NSMutableArray *modelsArray=[NSMutableArray array];
        for (NSDictionary *dic in listArr) {
            QiuShi *qiuShi=[[QiuShi alloc]initWithDictionary:dic];
            [modelsArray addObject:qiuShi]; 
        }
        block(modelsArray);
    }];
    
    [request setFailedBlock:^{
        NSError *error = request.error;
        NSLog(@"%@", [error description]);
    }];
    [request startAsynchronous];
}

@end
