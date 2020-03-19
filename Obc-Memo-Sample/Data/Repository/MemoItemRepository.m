//
//  MemoItemRepository.m
//  Obc-Memo-Sample
//
//  Created by kawaharadai on 2020/03/09.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MemoItemRepository.h"
#import "MemoItemDataStore.h"
#import "CoreDataError.h"
#import "NSString+.h"

@interface MemoItemRepositoryImpl ()
@property (nonatomic) NSObject<MemoItemDataStore> * _Nonnull memoItemDataStore;
@end

@implementation MemoItemRepositoryImpl

- (instancetype)initWith:(NSObject<MemoItemDataStore> * _Nonnull)memoItemDataStore {
    self = [super init];
    if (self) {
        self.memoItemDataStore = memoItemDataStore;
    }
    return self;
}

- (void)countAllMemoItems:(void (^ _Nonnull)(NSInteger * _Nonnull))completion {
    [self readAllMemoItems:^(NSArray<MemoItem *> * _Nullable memoItems, NSInteger * _Nullable errorCode) {
        if (errorCode == nil) {
            completion(memoItems.count);
        } else {
            completion(0);
        }
    }];
}

- (void)createMemoItem:(NSString * _Nonnull)text uniqueId:(NSString * _Nullable)uniqueId completion:(void (^ _Nonnull)(MemoItem * _Nullable, NSInteger * _Nullable))completion {
    [self.memoItemDataStore create:@"MemoItem" completion:^(MemoItem * _Nullable memoItem, CoreDataError * _Nullable error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            NSManagedObjectContext * _Nullable context = memoItem.managedObjectContext;
            if (context == nil) {
                completion(nil, NotFoundContext);
            } else {
                [context performBlockAndWait:^{
                    memoItem.title = text.firstLine;
                    memoItem.content = text.afterSecondLine;
                    memoItem.editDate = [NSDate new];
                    if (uniqueId == nil) {
                        [self countAllMemoItems:^(NSInteger * _Nonnull count) {
                            memoItem.uniqueId = [NSString stringWithFormat:@"%ld", (long)count + 1];
                        }];
                    } else {
                        memoItem.uniqueId = uniqueId;
                    }
                    [self.memoItemDataStore save:memoItem];
                }];
                completion(memoItem, nil);
            }
        }
    }];
}

- (void)deleteAllMemoItems:(NSString * _Nonnull)entityName
                completion:(void (^ _Nonnull)(void * _Nullable (*)(void), NSInteger * _Nullable))completion {
    NSFetchRequest * request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSBatchDeleteRequest * deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    CoreDataError * error = [self.memoItemDataStore execute:deleteRequest];
    if (error == nil) {
        completion(nil, nil);
    } else {
        completion(nil, error);
    }
}


- (void)deleteMemoItem:(NSString * _Nonnull)uniqueId
            completion:(void (^ _Nonnull)(void * _Nullable (*)(void), NSInteger * _Nullable))completion {
    [self readMemoItem:uniqueId completion:^(MemoItem * _Nullable memoItem, NSInteger * _Nullable errorCode) {
        if (errorCode != nil) {
            completion(nil, errorCode);
        } else {
            [self.memoItemDataStore delete:memoItem completion:^{
                completion(nil, nil);
            }];
        }
    }];
}


- (void)readAllMemoItems:(void (^ _Nonnull)(NSArray<MemoItem *> * _Nullable, NSInteger * _Nullable))completion {
    bool ascending = NO;
    [self.memoItemDataStore fetchArray:[[NSCompoundPredicate alloc] initWithType:NSAndPredicateType
                                                                   subpredicates:[NSArray<NSPredicate *> new]]
                               sortKey:@"editDate"
                             ascending:&ascending
                            completion:^(NSArray<MemoItem *> * _Nonnull memoItems, CoreDataError * _Nullable error) {
        if (error != nil) {
            completion([NSArray<MemoItem *> new], error);
        } else {
            completion(memoItems, nil);
        }
    }];
}


- (void)readMemoItem:(NSString * _Nonnull)uniqueId
          completion:(void (^ _Nonnull)(MemoItem * _Nullable, NSInteger * _Nullable))completion {
    bool ascending = NO;
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"uniqueId == %@", uniqueId];
    [self.memoItemDataStore fetchArray:[[NSCompoundPredicate alloc] initWithType:NSAndPredicateType
                                                                   subpredicates:[[NSArray<NSPredicate *> alloc] initWithObjects:predicate, nil]]
                               sortKey:@"editDate"
                             ascending:&ascending
                            completion:^(NSArray<MemoItem *> * _Nonnull memoItems, CoreDataError * _Nullable error) {
        if (error != nil) {
            completion(nil, error);
        } else {
            if (memoItems.count > 0) {
                completion(memoItems[0], nil);
            } else {
                completion(nil, FailedFetchMemoById);
            }
        }
    }];
}


- (void)updateMemoItem:(NSString * _Nonnull)uniqueId
                  text:(NSString * _Nonnull)text
            completion:(void (^ _Nonnull)(void * _Nullable (*)(void), NSInteger * _Nullable))completion {
    [self readMemoItem:uniqueId completion:^(MemoItem * _Nullable memoItem, NSInteger * _Nullable errorCode) {
        if (errorCode != nil) {
            completion(nil, errorCode);
        } else {
            NSManagedObjectContext * _Nullable context = memoItem.managedObjectContext;
            if (context == nil) {
                completion(nil, NotFoundContext);
            } else {
                [context performBlockAndWait:^{
                    memoItem.title = text.firstLine;
                    memoItem.content = text.afterSecondLine;
                    memoItem.editDate = [NSDate new];
                    // メモ内容更新
                    [self.memoItemDataStore save:memoItem];
                }];
                completion(nil, nil);
            }
        }
    }];
}

@end
