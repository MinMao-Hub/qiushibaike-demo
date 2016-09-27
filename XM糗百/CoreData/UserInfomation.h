//
//  UserInfomation.h
//  qiushibaikeProject
//
//  Created by  on 14-10-5.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfomation : NSManagedObject

@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * hobby;
@property (nonatomic, retain) NSString * introduce;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * sexy;
@property (nonatomic, retain) NSString * signature;
@property (nonatomic, retain) NSData * userIcon;
@property (nonatomic, retain) NSString * username;

@end
