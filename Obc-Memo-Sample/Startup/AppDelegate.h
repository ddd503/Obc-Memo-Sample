//
//  AppDelegate.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

