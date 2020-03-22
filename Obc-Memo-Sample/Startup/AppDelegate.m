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
#import <Obc_Memo_Sample-Swift.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow * window = [UIWindow new];
    UIViewController * startupVC = [ViewControllerBuilder buildMemoListVC];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:startupVC];
    window.rootViewController = navigationController;
    self.window = window;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSObject<MemoItemDataStore> * memoItemDataStore = [MemoItemDataStoreImpl new];
    [memoItemDataStore saveAtContext:CoreDataManager.shared.persistentContainer.viewContext];
}

@end
