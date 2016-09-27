//
//  RequestUserQiushi.h
//  qiushibaikeProject
//
//  Created by  on 14-9-22.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
typedef void(^userQiushi)(NSArray *);

@interface RequestUserQiushi : NSObject
+(void)requestUserQiushi:(NSString *)userId block:(userQiushi)block;


@end
