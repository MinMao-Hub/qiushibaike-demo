//
//  UserDataManager.h
//  qiushibaikeProject
//
//  Created by  on 14-9-29.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CoreDataDAO.h"
#import "UserInfoModel.h"
@interface UserDataManager : CoreDataDAO

+ (UserDataManager *)shareUserDataManager;
- (void)insertData:(UserInfoModel *)model;
- (BOOL)findData:(UserInfoModel *)model;
- (BOOL)updataData:(UserInfoModel *)model;
- (NSArray *)findModifyUser:(NSString *)userName;


@end
