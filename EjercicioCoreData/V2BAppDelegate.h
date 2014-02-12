//
//  V2BAppDelegate.h
//  EjercicioCoreData
//
//  Created by LLBER on 12/02/14.
//  Copyright (c) 2014 video2brain. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface V2BAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end
