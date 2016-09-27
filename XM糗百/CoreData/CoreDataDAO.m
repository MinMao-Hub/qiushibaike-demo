//
//  CoreDataDAO.m
//  CoreData
//
//  Created by  on 14-8-31.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "CoreDataDAO.h"

@implementation CoreDataDAO
@synthesize managedObjectModel=_managedObjectModel;
@synthesize managedObjectContext= _managedObjectContext;
@synthesize persistentStoreCoordinator= _persistentStoreCoordinator;
-(NSManagedObjectContext *)managedObjectContext
{
    if(_managedObjectContext){
        return _managedObjectContext;
        
    }
    
    NSPersistentStoreCoordinator *coordinator=[self persistentStoreCoordinator];
    if(coordinator!=nil){
        _managedObjectContext=[[NSManagedObjectContext alloc]init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        
    }
    return _managedObjectContext;
}
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(_persistentStoreCoordinator){
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL=[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UserDataBase.sqlite"];
    _persistentStoreCoordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    return _persistentStoreCoordinator; 
}
-(NSManagedObjectModel *)managedObjectModel
{
    if(_managedObjectContext){
        return _managedObjectModel;
    }
    NSURL *modelURL=[[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"];
    _managedObjectModel=[[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
-(NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
