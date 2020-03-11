//
//  MemoItemDataStore.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/07.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoItemDataStore.h"
#import "CoreDataManager.h"

@implementation MemoItemDataStoreImpl

- (void)create:(NSString * _Nonnull)entityName
    completion:(void (^ _Nonnull)(MemoItem * _Nullable,
                                  CoreDataError * _Nullable))completion {
    NSManagedObjectContext * _Nonnull context = CoreDataManager.shared.persistentContainer.viewContext;
    NSEntityDescription * _Nullable entity = [NSEntityDescription entityForName:entityName
                                                         inManagedObjectContext:context];
    if (entity == nil) {
        completion(nil, FailedCreateEntity);
        return;
    }

    MemoItem * _Nullable memoItem = [[MemoItem alloc] initWithEntity:entity
                                      insertIntoManagedObjectContext:context];
    completion(memoItem, nil);
}

- (void)delete:(NSManagedObject * _Nonnull)object
    completion:(void (^ _Nonnull)(void))completion {
    NSManagedObjectContext * _Nonnull context = CoreDataManager.shared.persistentContainer.viewContext;
    [context performBlockAndWait:^{
        [context deleteObject:object];
        completion();
    }];
}

- (nullable CoreDataError *)execute:(NSPersistentStoreRequest * _Nonnull)request {
    NSManagedObjectContext * _Nonnull context = CoreDataManager.shared.persistentContainer.viewContext;
    NSError * _Nullable error = nil;

    BOOL isSuccess = [context executeRequest:request error:&error];

    if (isSuccess) {
        return nil;
    } else {
        return FailedExecuteStoreRequest;
    }
}

- (void)fetchArray:(NSCompoundPredicate * _Nonnull)predicates
           sortKey:(NSString * _Nonnull)sortKey
         ascending:(BOOL * _Nonnull)ascending
        completion:(void (^ _Nonnull)(NSArray<MemoItem *> * _Nullable,
                                      CoreDataError * _Nullable))completion {
    NSManagedObjectContext * _Nonnull context = CoreDataManager.shared.persistentContainer.viewContext;
    NSFetchRequest<MemoItem *> * _Nonnull fetchRequest = [MemoItem fetchRequest];
    NSSortDescriptor * _Nonnull sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:ascending];
    fetchRequest.sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    fetchRequest.predicate = predicates;
    NSFetchedResultsController * _Nonnull resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                  managedObjectContext:context
                                                                                                    sectionNameKeyPath:nil
                                                                                                             cacheName:nil];
    NSError * _Nullable error = nil;

    BOOL isSuccess = [resultsController performFetch:&error];

    if (isSuccess) {
        if (resultsController.fetchRequest != nil) {
            return completion(resultsController.fetchedObjects, nil);
        } else {
            return completion([NSArray<MemoItem *> new], nil);
        }
    } else {
        return completion(nil, FailedFetchRequest);
    }
}

- (nullable CoreDataError *)save:(NSManagedObject * _Nonnull)object {
    NSManagedObjectContext * _Nullable context = object.managedObjectContext;
    if (context == nil) {
        return NotFoundContext;
    }
    if (context.hasChanges) {
        NSError * _Nullable error = nil;

        BOOL isSuccess = [context save:&error];

        if (isSuccess) {
            return nil;
        } else {
            return FailedSaveContext;
        }
    }
    return nil;
}

- (void)saveAtContext:(NSManagedObjectContext * _Nonnull)context {
    if (context.hasChanges) {
        [context save:nil];
    }
}

@end
