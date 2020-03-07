//
//  CoreDataManager.h
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/07.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject
@property (readonly, strong) NSPersistentContainer *persistentContainer;
+ (CoreDataManager *)shared;
@end
