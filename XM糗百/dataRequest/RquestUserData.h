//
//  RquestUserData.h
//  QiushiBaike
//
//  Created by  on 14-9-17.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^userData)(NSArray *);

@interface RquestUserData : NSObject
+(void)requestUserData:(NSString *)userId block:(userData)block;


@end
