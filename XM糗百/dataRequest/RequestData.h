//
//  RequestData.h
//  QiushiBaike
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^FinishData)(NSArray *);

@interface RequestData : NSObject
+(void)requestData:(NSString *)urlString block:(FinishData)block;


@end
