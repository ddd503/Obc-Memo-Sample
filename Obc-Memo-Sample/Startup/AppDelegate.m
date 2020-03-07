//
//  AppDelegate.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "AppDelegate.h"
#import "MemoItemDataStore.h"
#import "CoreDataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MemoItemDataStoreImpl saveAtContext:CoreDataManager.shared.persistentContainer.viewContext];
}

@end
