//
//  RequestComents.h
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^qiushiComents)(NSArray *);
@interface RequestComents : NSObject
+(void)requestComentsdata:(NSString *)qiushiId block:(qiushiComents)block; 

@end
