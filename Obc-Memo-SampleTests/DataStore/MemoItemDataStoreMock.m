//
//  MemoItemDataStoreMock.m
//  Obc-Memo-SampleTests
//
//  Created by kawaharadai on 2020/03/17.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

#import "MemoItemDataStoreMock.h"
#import "MemoItemMock.h"

@implementation MemoItemDataStoreMock

- (instancetype)initWith:(Boolean)isSuccessFunc {
    self = [super init];
    if (self) {
        self.dummyDataBase = [NSMutableArray<MemoItem *> new];
        self.isSuccessFunc = isSuccessFunc;
    }
    return self;
}

- (void)create:(NSString * _Nonnull)entityName
    completion:(void (^ _Nonnull)(MemoItem * _Nullable, CoreDataError * _Nullable))completion {
    if (self.isSuccessFunc) {
        MemoItem * _Nullable memoItem = [[MemoItemMock alloc] initWith:@"1"
                                                             titleText:@"title"
                                                           contentText:@"content"
                                                          editMemoDate:[NSDate new]];
        completion(memoItem, nil);
    } else {
        completion(nil, FailedCreateEntity);
    }
}

- (void)delete:(MemoItem * _Nonnull)memoItem completion:(void (^ _Nonnull)(void))completion {
    if (self.isSuccessFunc) {
        NSMutableArray<MemoItem *> * mutableDataBase = [NSMutableArray<MemoItem *> new];
        for (MemoItem * item in self.dummyDataBase) {
            if (item.uniqueId != memoItem.uniqueId) {
                [mutableDataBase addObject:item];
            }
        }
        self.dummyDataBase = mutableDataBase;
    }
    completion();
}

- (nullable CoreDataError *)execute:(NSPersistentStoreRequest * _Nonnull)request {
    if (self.isSuccessFunc) {
        if ([request isKindOfClass:NSBatchDeleteRequest.class]) {
            self.dummyDataBase = [NSMutableArray<MemoItem *> new];
        }
        return nil;
    } else {
        return FailedExecuteStoreRequest;
    }
}

- (void)fetchArray:(NSCompoundPredicate * _Nonnull)predicates
           sortKey:(NSString * _Nonnull)sortKey
         ascending:(BOOL * _Nonnull)ascending
        completion:(void (^ _Nonnull)(NSArray<MemoItem *> * _Nonnull,
                                      CoreDataError * _Nullable))completion {
    if (self.isSuccessFunc) {
        NSMutableArray<MemoItem *> * mutableDataBase = [[NSMutableArray<MemoItem *> alloc] initWithArray:self.dummyDataBase];
        [mutableDataBase filterUsingPredicate:predicates];
        completion(mutableDataBase, nil);
    } else {
        completion([NSMutableArray<MemoItem *> new], FailedFetchRequest);
    }
}

- (nullable CoreDataError *)save:(MemoItem * _Nonnull)memoItem {
    if (self.isSuccessFunc) {
        NSMutableArray<MemoItem *> * mutableDataBase = [NSMutableArray<MemoItem *> new];
        for (MemoItem * item in self.dummyDataBase) {
            if (item.uniqueId != memoItem.uniqueId) {
                [mutableDataBase addObject:item];
            }
        }
        [mutableDataBase addObject:memoItem];
        self.dummyDataBase = mutableDataBase;
        return nil;
    } else {
        return FailedSaveContext;
    }
}

- (void)saveAtContext:(NSManagedObjectContext * _Nonnull)context {}

@end
