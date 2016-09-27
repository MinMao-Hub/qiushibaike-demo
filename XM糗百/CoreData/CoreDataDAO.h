//
//  CoreDataDAO.h
//  CoreData
//
//  Created by  on 14-8-31.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataDAO : NSObject
@property(readonly,strong,nonatomic)NSManagedObjectContext *managedObjectContext;
@property(readonly,strong,nonatomic)NSManagedObjectModel   *managedObjectModel;
@property(readonly,strong,nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;
-(NSURL *)applicationDocumentsDirectory;

@end
