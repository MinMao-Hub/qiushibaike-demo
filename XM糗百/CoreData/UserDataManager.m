//
//  UserDataManager.m
//  qiushibaikeProject
//
//  Created by  on 14-9-29.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "UserDataManager.h"
#import "UserInfomation.h"

@implementation UserDataManager
+ (UserDataManager *)shareUserDataManager
{
    static UserDataManager *shared =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared =[[UserDataManager alloc]init];
    });
    return shared;
}

- (void)insertData:(UserInfoModel *)model
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    UserInfomation *userInfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfomation" inManagedObjectContext:cxt];
    [userInfo setValue:model.userName  forKey:@"username"];
    [userInfo setValue:model.passWord  forKey:@"password"];
    [userInfo setValue:model.hobby     forKey:@"hobby"];
    [userInfo setValue:model.age       forKey:@"age"];
    [userInfo setValue:model.signature forKey:@"signature"];
    [userInfo setValue:model.sexy      forKey:@"sexy"];
    [userInfo setValue:model.introduce forKey:@"introduce"];
    [userInfo setValue:model.location  forKey:@"location"];
    [userInfo setValue:model.userIcon  forKey:@"userIcon"];

    NSError *savingError = nil;
    if ([self.managedObjectContext save:&savingError]){
        NSLog(@"数据插入成功！");
    }else{
        NSLog(@"数据插入失败！");
    }
    
    
}
- (BOOL)findData:(UserInfoModel *)model
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserInfomation" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username like %@&&password like %@",model.userName,model.passWord];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [NSArray array];
    listData = [cxt executeFetchRequest:request error:&error];
    if (listData.count > 0)
    {
        return YES;
    }
    return NO;
}

- (BOOL)updataData:(UserInfoModel *)model;
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserInfomation" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username like %@",model.userName];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if (listData.count > 0)
    {
        UserInfomation *userInfo = [listData lastObject];
        //[userInfo setValue:model.userName  forKey:@"username"];
        //[userInfo setValue:model.passWord  forKey:@"password"];
        [userInfo setValue:model.hobby     forKey:@"hobby"];
        [userInfo setValue:model.age       forKey:@"age"];
        [userInfo setValue:model.signature forKey:@"signature"];
        [userInfo setValue:model.sexy      forKey:@"sexy"];
        [userInfo setValue:model.introduce forKey:@"introduce"];
        [userInfo setValue:model.location  forKey:@"location"];
        [userInfo setValue:model.userIcon  forKey:@"userIcon"];
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]){
            NSLog(@"数据修改成功！");
        }else{
            NSLog(@"数据修改失败！");
            return NO;
        }
    }
    return YES;
}

- (NSArray *)findModifyUser:(NSString *)userName
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"UserInfomation" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username like %@",userName];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [NSArray array];
    listData = [cxt executeFetchRequest:request error:&error];
    if (listData.count > 0)
    {
        return listData;
    }
    return nil;

    
}

@end
